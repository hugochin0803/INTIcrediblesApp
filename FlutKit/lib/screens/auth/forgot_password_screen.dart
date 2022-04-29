/*
* File : Forgot Password
* Version : 1.0.0
* */

import 'dart:convert';
import 'dart:io';

import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/screens/auth/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  var studentidController = TextEditingController();

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
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
                Positioned(
                  left: 30,
                  right: 30,
                  top: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    children: <Widget>[
                      FxContainer.bordered(
                        color: theme.scaffoldBackgroundColor,
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 24, top: 8),
                              child:
                                  FxText.h6("FORGOT PASSWORD", fontWeight: 600),
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
                                    controller: studentidController,
                                    keyboardType: TextInputType.text,
                                    onSaved: (value) {
                                      studentidController.text = (value)!;
                                    },
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
                                    child: FxButton(
                                        elevation: 0,
                                        borderRadiusAll: 4,
                                        onPressed: () {
                                          forgetpassword();
                                        },
                                        child: FxText.button("RESET PASSWORD",
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
            )));
  }

  Future<void> forgetpassword() async {
    if (studentidController.text.isNotEmpty) {
      String studentid = studentidController.text;

      final uri =
          Uri.http('chilamlol.pythonanywhere.com', '/account/info/$studentid');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.get(uri, headers: headers);

      var futureGetInfo = GetInfo.fromJson(jsonDecode(response.body));

      String email = futureGetInfo.personalEmail;
      int userId = futureGetInfo.userId;

      if (futureGetInfo.error.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Invalid Student ID! Please try again!")));
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("forgotPassword", true);
        prefs.setString("resetEmail", email);
        prefs.setInt("resetUserId", userId);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => otpVerification()),
        );
      }
    }
  }
}

class GetInfo {
  final String personalEmail;
  final int userId;
  final String error;

  GetInfo({this.userId = 0, this.personalEmail = "", this.error = ""});

  factory GetInfo.fromJson(Map<String, dynamic> json) {
    if (json['error'] == null) {
      return GetInfo(
          userId: json['userId'], personalEmail: json['personalEmail']);
    } else {
      return GetInfo(error: json['error']);
    }
  }
}
