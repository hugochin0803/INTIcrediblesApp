/*
* File : Login
* Version : 1.0.0
* */

import 'dart:convert';
import 'dart:io';
import 'package:flutkit/screens/auth/login_screen.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class resetPassword extends StatefulWidget {
  @override
  _resetPassword createState() => _resetPassword();
}

// ignore: camel_case_types
class _resetPassword extends State<resetPassword> {
  bool? _passwordVisible1 = false; //_check1 = false;
  bool? _passwordVisible2 = false; // _check2 = false;
  late CustomTheme customTheme;
  late ThemeData theme;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var _pass = TextEditingController();
  var _confirmPass = TextEditingController();

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
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/images/all/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 30,
              right: 30,
              top: MediaQuery.of(context).size.height * 0.15,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  FxContainer.bordered(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    color: theme.scaffoldBackgroundColor,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 1, top: 8),
                          child: FxText.h6("Reset Password",
                              fontWeight: 800, fontSize: 25),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10, top: 0),
                          child: FxText.h6("Please reset your password",
                              fontWeight: 400, fontSize: 16),
                        ),
                        Container(
                          height: 150.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/all/lock.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 16, right: 16),
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
                                      hintText: "New Password",
                                      hintStyle: FxTextStyle.sh2(
                                          letterSpacing: 0.1,
                                          color: theme.colorScheme.onBackground,
                                          fontWeight: 500),
                                      prefixIcon: Icon(MdiIcons.lockOutline),
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
                                    margin: EdgeInsets.only(top: 16),
                                    child: TextFormField(
                                      style: FxTextStyle.b1(
                                          letterSpacing: 0.1,
                                          color: theme.colorScheme.onBackground,
                                          fontWeight: 500),
                                      controller: _confirmPass,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please re-enter password";
                                        }

                                        if (_pass.text != _confirmPass.text) {
                                          return "Password do not match";
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
                                        prefixIcon: Icon(MdiIcons.lockOutline),
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
                                    margin: EdgeInsets.only(top: 16),
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

  Future<void> resetPassword() async {
    if (_pass.text.isNotEmpty && _confirmPass.text.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
      final userID = prefs.getInt('resetUserId') ?? 0;
      final body = {
        'userId': userID,
        'password': generateMd5(_confirmPass.text)
      };
      final jsonString = json.encode(body);
      final uri =
          Uri.http('chilamlol.pythonanywhere.com', '/account/reset-password');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.post(uri, headers: headers, body: jsonString);

      if (response.statusCode == 200) {
        var futureResetPassword =
            ResetPasswordState.fromJson(jsonDecode(response.body));

        if (futureResetPassword.status == "200") {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Password reset successful!")));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login2Screen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "There is an issue on our end! Please contact admin for assistance!")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Server Error")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Blank Field Not Allowed")));
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
