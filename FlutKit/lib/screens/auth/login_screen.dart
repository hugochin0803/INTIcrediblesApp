/*
* File : Login
* Version : 1.0.0
* */

import 'dart:io';

import 'package:flutkit/screens/auth/firstTime_login_Screen.dart';
import 'package:flutkit/screens/auth/update_profile.dart';
import 'package:flutkit/screens/auth/otp_verification.dart';
import 'package:flutkit/screens/event/event_full_app.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/screens/auth/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

class Login2Screen extends StatefulWidget {
  @override
  _Login2ScreenState createState() => _Login2ScreenState();
}

class _Login2ScreenState extends State<Login2Screen> {
  bool? _passwordVisible = true; //_check = true;
  late CustomTheme customTheme;
  late ThemeData theme;

  var idController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    clearVariable();
  }

  void clearVariable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("forgotPassword");
    prefs.remove("resetEmail");
    prefs.remove("resetUserId");
  }

  String generateMd5(String input) {
    developer.log(md5.convert(utf8.encode(input)).toString(), name: 'MD5');
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/all/background.png'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                new Positioned(
                  left: 30,
                  right: 30,
                  top: MediaQuery.of(context).size.height * 0.2,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      FxContainer.bordered(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        color: theme.scaffoldBackgroundColor,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 100.0,
                              width: 300.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/all/login_logo.png'),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 24, top: 8),
                              child: FxText.h6("LOGIN", fontWeight: 600),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    style: FxTextStyle.b1(
                                        letterSpacing: 0.1,
                                        color: theme.colorScheme.onBackground,
                                        fontWeight: 500),
                                    autofocus: false,
                                    controller: idController,
                                    keyboardType: TextInputType.text,
                                    onSaved: (value) {
                                      idController.text = (value)!;
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: "Student ID",
                                      hintStyle: FxTextStyle.sh2(
                                          letterSpacing: 0.1,
                                          color: theme.colorScheme.onBackground,
                                          fontWeight: 500),
                                      prefixIcon: Icon(MdiIcons.emailOutline),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: TextFormField(
                                      style: FxTextStyle.b1(
                                          letterSpacing: 0.1,
                                          color: theme.colorScheme.onBackground,
                                          fontWeight: 500),
                                      autofocus: false,
                                      controller: passwordController,
                                      keyboardType: TextInputType.text,
                                      onSaved: (value) {
                                        passwordController.text = (value)!;
                                      },
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: FxTextStyle.sh2(
                                            letterSpacing: 0.1,
                                            color:
                                                theme.colorScheme.onBackground,
                                            fontWeight: 500),
                                        prefixIcon: Icon(MdiIcons.lockOutline),
                                        suffixIcon: IconButton(
                                          icon: Icon(_passwordVisible!
                                              ? MdiIcons.eyeOutline
                                              : MdiIcons.eyeOffOutline),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible =
                                                  !_passwordVisible!;
                                            });
                                          },
                                        ),
                                      ),
                                      obscureText: _passwordVisible!,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                      alignment: Alignment.centerRight,
                                      child: FxButton.text(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgotPasswordScreen()),
                                            );
                                          },
                                          child: FxText.b1(
                                            "Forgot Password?",
                                            fontWeight: 300,
                                            fontSize: 14,
                                          ))),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: FxButton.block(
                                        elevation: 0,
                                        borderRadiusAll: 4,
                                        padding: FxSpacing.y(12),
                                        onPressed: () {
                                          login();
                                        },
                                        child: FxText.button("LOGIN",
                                            fontWeight: 600,
                                            color: theme.colorScheme.onPrimary,
                                            letterSpacing: 0.5)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  Future<void> login() async {
    if (passwordController.text.isNotEmpty && idController.text.isNotEmpty) {
      final body = {
        'username': idController.text,
        'password': generateMd5(passwordController.text)
      };
      final jsonString = json.encode(body);
      final uri = Uri.http('chilamlol.pythonanywhere.com', '/login');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      try {
        final response =
            await http.post(uri, headers: headers, body: jsonString);

        if (response.statusCode == 200) {
          var futureLogin = LoginState.fromJson(jsonDecode(response.body));

          if (futureLogin.loginStatus == 1) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
          } else {
            final prefs = await SharedPreferences.getInstance();

            // set value
            prefs.setInt('userID', futureLogin.userID);
            prefs.setString('name', futureLogin.name);
            if (futureLogin.userRole == 1) {
              if (futureLogin.activationStatus == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => firstTimeLogin()),
                );
              } else if (futureLogin.activationStatus == 10) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => updateProfile()),
                );
              } else if (futureLogin.activationStatus == 20) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => otpVerification()),
                );
              } else if (futureLogin.activationStatus == 30) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("isLoggedIn", true);
                prefs.setString("token", futureLogin.token);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => EventFullApp()),
                    (Route<dynamic> route) => false);
              }
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
            }
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Server Error")));
        }
      } on SocketException catch (e) {
        print('Socket Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Unable to connect to server!\nPlease contact admin for more information!")));
      } on Error catch (e) {
        print('General Error: $e');
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Blank Field Not Allowed")));
    }
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
