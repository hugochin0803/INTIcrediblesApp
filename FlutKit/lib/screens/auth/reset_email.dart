/*
* File : Login
* Version : 1.0.0
* */

import 'dart:convert';
import 'dart:io';
import 'package:flutkit/screens/auth/login_screen.dart';
import 'package:flutkit/screens/auth/reset_email2.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class resetEmail extends StatefulWidget {
  final String username;
  const resetEmail({Key? key, required this.username}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _resetEmail(username);
  }
}

// ignore: camel_case_types
class _resetEmail extends State<resetEmail> {
  String username;
  _resetEmail(this.username);
  bool? _passwordVisible1 = false; //_check1 = false;
  late CustomTheme customTheme;
  late ThemeData theme;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final _pass = TextEditingController();

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/all/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 30,
              right: 30,
              top: MediaQuery.of(context).size.height * 0.30,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  FxContainer.bordered(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    color: theme.scaffoldBackgroundColor,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 10, top: 8),
                          child: FxText.h6("Confirm Your Password",
                              fontWeight: 800, fontSize: 25),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 10, top: 0),
                          child: FxText.h6(
                              "Please enter your password to continue:",
                              fontWeight: 400,
                              fontSize: 16),
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    style: FxTextStyle.b1(
                                        letterSpacing: 0.1,
                                        color: theme.colorScheme.onBackground,
                                        fontWeight: 500),
                                    controller: _pass,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter password";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: FxTextStyle.sh2(
                                          letterSpacing: 0.1,
                                          color: theme.colorScheme.onBackground,
                                          fontWeight: 500),
                                      prefixIcon:
                                          const Icon(MdiIcons.lockOutline),
                                      suffixIcon: IconButton(
                                        icon: Icon(_passwordVisible1!
                                            ? MdiIcons.eyeOutline
                                            : MdiIcons.eyeOffOutline),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible1 =
                                                !_passwordVisible1!;
                                          });
                                        },
                                      ),
                                    ),
                                    obscureText: _passwordVisible1!,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: FxButton.block(
                                        elevation: 0,
                                        borderRadiusAll: 4,
                                        padding: FxSpacing.y(12),
                                        onPressed: () {
                                          if (_formkey.currentState!
                                              .validate()) {
                                            confirmPassword(username);
                                          }
                                        },
                                        child: FxText.button("Confirm Password",
                                            fontWeight: 600,
                                            color: theme.colorScheme.onPrimary,
                                            letterSpacing: 0.5)),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: FxSpacing.safeAreaTop(context) + 12,
              left: 16,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  FeatherIcons.chevronLeft,
                  color: theme.colorScheme.onBackground,
                ),
              ),
            )
          ],
        ));
  }

  Future<void> confirmPassword(String username) async {
    if (_pass.text.isNotEmpty && username.isNotEmpty) {
      final body = {'username': username, 'password': generateMd5(_pass.text)};
      final jsonString = json.encode(body);
      final uri = Uri.http('chilamlol.pythonanywhere.com', '/login');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      try {
        final response =
            await http.post(uri, headers: headers, body: jsonString);

        if (response.statusCode == 200) {
          var futureLogin = LoginState.fromJson(jsonDecode(response.body));

          if (futureLogin.loginStatus == 1) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Invalid Credentials")));
          } else {
            if (futureLogin.userRole == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const resetEmail2()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Invalid Credentials")));
            }
          }
        } else if (response.statusCode == 401 || response.statusCode == 400) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid Credentials")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Server Error")));
        }
      } on SocketException catch (e) {
        if (kDebugMode) {
          print('Socket Error: $e');
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Unable to connect to server!\nPlease contact admin for more information!")));
      } on Error catch (e) {
        if (kDebugMode) {
          print('General Error: $e');
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Blank Field Not Allowed")));
    }
  }
}

class ResetPasswordState {
  final String message;
  final String status;

  ResetPasswordState({
    required this.message,
    required this.status,
  });

  factory ResetPasswordState.fromJson(Map<String, dynamic> json) {
    return ResetPasswordState(message: json['message'], status: json['status']);
  }
}

class LoginState {
  final int loginStatus;
  final int userID;
  final int activationStatus;
  final String name;
  final String token;
  final int userRole;

  LoginState(
      {required this.loginStatus,
      required this.userID,
      required this.activationStatus,
      required this.name,
      required this.token,
      required this.userRole});

  factory LoginState.fromJson(Map<String, dynamic> json) {
    return LoginState(
        loginStatus: json['loginStatus'],
        userID: json['userID'],
        activationStatus: json['activationStatus'],
        name: json['name'],
        token: json['token'],
        userRole: json['userRole']);
  }
}
