/*
* File : Login
* Version : 1.0.0
* */

import 'dart:convert';
import 'dart:io';
import 'package:flutkit/screens/auth/update_profile.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class firstTimeLogin extends StatefulWidget {
  const firstTimeLogin({Key? key}) : super(key: key);

  @override
  _firstTimeLogin createState() => _firstTimeLogin();
}

// ignore: camel_case_types
class _firstTimeLogin extends State<firstTimeLogin> {
  bool? _passwordVisible1 = true;
  bool? _passwordVisible2 = true;

  late CustomTheme customTheme;
  late ThemeData theme;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final _pass = TextEditingController();
  final _confirmPass = TextEditingController();

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
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/all/background.png'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: <Widget>[
                  FxContainer.bordered(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    color: theme.scaffoldBackgroundColor,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 1, top: 8),
                          child: FxText.h6("First Time Login?",
                              fontWeight: 800, fontSize: 25),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 0),
                          child: FxText.h6("Please reset your password",
                              fontWeight: 400, fontSize: 16),
                        ),
                        Container(
                          height: 150.0,
                          width: 150.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/all/lock.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.rectangle,
                          ),
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
                                        return "Please enter password!";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "New Password",
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
                                    child: TextFormField(
                                      style: FxTextStyle.b1(
                                          letterSpacing: 0.1,
                                          color: theme.colorScheme.onBackground,
                                          fontWeight: 500),
                                      controller: _confirmPass,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please re-enter password!";
                                        }

                                        if (_pass.text != _confirmPass.text) {
                                          return "Password do not match!";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Confirm Password",
                                        hintStyle: FxTextStyle.sh2(
                                            letterSpacing: 0.1,
                                            color:
                                                theme.colorScheme.onBackground,
                                            fontWeight: 500),
                                        prefixIcon:
                                            const Icon(MdiIcons.lockOutline),
                                        suffixIcon: IconButton(
                                          icon: Icon(_passwordVisible2!
                                              ? MdiIcons.eyeOutline
                                              : MdiIcons.eyeOffOutline),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible2 =
                                                  !_passwordVisible2!;
                                            });
                                          },
                                        ),
                                      ),
                                      obscureText: _passwordVisible2!,
                                    ),
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
                                            resetPassword();
                                          }
                                        },
                                        child: FxText.button("Reset Password",
                                            fontWeight: 600,
                                            color: theme.colorScheme.onPrimary,
                                            letterSpacing: 0.5)),
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 10, 0, 0),
                                      child: Column(children: [
                                        FxText(
                                          "*Password must be at least 8 characters\n*Password must consist at least:",
                                          fontWeight: 400,
                                          fontSize: 10,
                                          color: theme.colorScheme.primary,
                                        ),
                                        FxText(
                                          "1 Numeric/Symbol",
                                          fontWeight: 400,
                                          fontSize: 10,
                                          color: theme.colorScheme.primary,
                                        ),
                                      ])),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> resetPassword() async {
    if (_pass.text.isNotEmpty && _confirmPass.text.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();

      final userID = prefs.getInt('userID') ?? 0;
      final body = {'password': generateMd5(_confirmPass.text)};
      final jsonString = json.encode(body);
      final uri = Uri.http(
          'chilamlol.pythonanywhere.com', '/account/reset-password/$userID');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.put(uri, headers: headers, body: jsonString);

      if (response.statusCode == 200) {
        var futureResetPassword =
            ResetPasswordState.fromJson(jsonDecode(response.body));

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const updateProfile()),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Server Error")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Blank Field Not Allowed")));
    }
  }
}

class ResetPasswordState {
  final String message;

  ResetPasswordState({
    required this.message,
  });

  factory ResetPasswordState.fromJson(Map<String, dynamic> json) {
    return ResetPasswordState(message: json['message']);
  }
}
