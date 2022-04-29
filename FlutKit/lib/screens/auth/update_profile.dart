/*
* File : Login
* Version : 1.0.0
* */

import 'dart:convert';
import 'dart:io';

import 'package:flutkit/screens/auth/otp_verification.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class updateProfile extends StatefulWidget {
  @override
  _updateProfile createState() => _updateProfile();
}

// ignore: camel_case_types
class _updateProfile extends State<updateProfile> {
  // bool? _passwordVisible = false, _check = false;
  late CustomTheme customTheme;
  late ThemeData theme;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var email = TextEditingController();
  var confirmEmail = TextEditingController();
  var handphone = TextEditingController();
  var telephone = TextEditingController();

  late Future<GetAlumniState> futureGetAlumni;
  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
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
                          child: FxText.h6("Update Profile",
                              fontWeight: 800, fontSize: 25),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10, top: 0),
                          child: FxText.h6("Please update your profile here",
                              fontWeight: 400, fontSize: 16),
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
                                    controller: email,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter email';
                                      }
                                      if (!RegExp(
                                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                          .hasMatch(value)) {
                                        return 'Please enter valid Email';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Personal Email",
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
                                      controller: confirmEmail,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter email';
                                        }
                                        if (!RegExp(
                                                "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                            .hasMatch(value)) {
                                          return 'Please enyer valid Email';
                                        }
                                        if (email.text != confirmEmail.text) {
                                          return "Email do not match";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Confirm Email",
                                        hintStyle: FxTextStyle.sh2(
                                            letterSpacing: 0.1,
                                            color:
                                                theme.colorScheme.onBackground,
                                            fontWeight: 500),
                                        prefixIcon: Icon(MdiIcons.emailOutline),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: TextFormField(
                                      style: FxTextStyle.b1(
                                          letterSpacing: 0.1,
                                          color: theme.colorScheme.onBackground,
                                          fontWeight: 500),
                                      controller: handphone,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter handphone ';
                                        }

                                        if (value.length < 9) {
                                          return 'Please enter correct format';
                                        }

                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Hand Phone",
                                        hintStyle: FxTextStyle.sh2(
                                            letterSpacing: 0.1,
                                            color:
                                                theme.colorScheme.onBackground,
                                            fontWeight: 500),
                                        prefixIcon: Icon(MdiIcons.phone),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: TextFormField(
                                      style: FxTextStyle.b1(
                                          letterSpacing: 0.1,
                                          color: theme.colorScheme.onBackground,
                                          fontWeight: 500),
                                      controller: telephone,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter telephone';
                                        }

                                        if (value.length < 9) {
                                          return 'Please enter correct format';
                                        }

                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Telephone Phone",
                                        hintStyle: FxTextStyle.sh2(
                                            letterSpacing: 0.1,
                                            color:
                                                theme.colorScheme.onBackground,
                                            fontWeight: 500),
                                        prefixIcon: Icon(MdiIcons.phoneDial),
                                      ),
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
                                            getAlumni();
                                          }
                                        },
                                        child: FxText.button("SUBMIT",
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

  Future<void> getAlumni() async {
    if (email.text.isNotEmpty &&
        confirmEmail.text.isNotEmpty &&
        handphone.text.isNotEmpty &&
        telephone.text.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
      final userID = prefs.getInt('userID') ?? 0;
      final body = {
        'userId': userID,
        'email': confirmEmail.text,
        'handphone': handphone.text,
        'telephone': telephone.text
      };
      final jsonString = json.encode(body);
      final uri =
          Uri.http('chilamlol.pythonanywhere.com', '/account/update-profile');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.post(uri, headers: headers, body: jsonString);

      if (response.statusCode == 200) {
        var futureGetAlumni =
            GetAlumniState.fromJson(jsonDecode(response.body));

        if (futureGetAlumni.status == "200") {
          prefs.setString('email', confirmEmail.text);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => otpVerification()),
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

// class _MyCustomClipper extends CustomClipper<Path> {
//   final BuildContext _context;

//   _MyCustomClipper(this._context);

//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     Size size = MediaQuery.of(_context).size;
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width, size.height * 0.3);
//     path.lineTo(0, size.height * 0.6);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper oldClipper) {
//     return false;
//   }
// }

class GetAlumniState {
  final String message;
  final String status;

  GetAlumniState({
    required this.message,
    required this.status,
  });

  factory GetAlumniState.fromJson(Map<String, dynamic> json) {
    return GetAlumniState(message: json['message'], status: json['status']);
  }
}
