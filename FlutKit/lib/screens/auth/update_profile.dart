/*
* File : Login
* Version : 1.0.0
* */

import 'dart:convert';
import 'dart:io';

import 'package:flutkit/screens/auth/otp_verification.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class updateProfile extends StatefulWidget {
  const updateProfile({Key? key}) : super(key: key);

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
    getAlumniData();
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
                            child: FxText.h6("Update Profile",
                                fontWeight: 800, fontSize: 25),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10, top: 0),
                            child: FxText.h6("Please update your profile here",
                                fontWeight: 400, fontSize: 16),
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
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
                                            color:
                                                theme.colorScheme.onBackground,
                                            fontWeight: 500),
                                        prefixIcon:
                                            const Icon(MdiIcons.emailOutline),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 16),
                                      child: TextFormField(
                                        style: FxTextStyle.b1(
                                            letterSpacing: 0.1,
                                            color:
                                                theme.colorScheme.onBackground,
                                            fontWeight: 500),
                                        controller: confirmEmail,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter email';
                                          }
                                          if (!RegExp(
                                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                              .hasMatch(value)) {
                                            return 'Please enter valid email';
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
                                              color: theme
                                                  .colorScheme.onBackground,
                                              fontWeight: 500),
                                          prefixIcon:
                                              const Icon(MdiIcons.emailOutline),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 16),
                                      child: TextFormField(
                                        style: FxTextStyle.b1(
                                            letterSpacing: 0.1,
                                            color:
                                                theme.colorScheme.onBackground,
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
                                              color: theme
                                                  .colorScheme.onBackground,
                                              fontWeight: 500),
                                          prefixIcon:
                                              const Icon(MdiIcons.phone),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 16),
                                      child: TextFormField(
                                        style: FxTextStyle.b1(
                                            letterSpacing: 0.1,
                                            color:
                                                theme.colorScheme.onBackground,
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
                                              color: theme
                                                  .colorScheme.onBackground,
                                              fontWeight: 500),
                                          prefixIcon:
                                              const Icon(MdiIcons.phoneDial),
                                        ),
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
                                              getAlumni();
                                            }
                                          },
                                          child: FxText.button("SUBMIT",
                                              fontWeight: 600,
                                              color:
                                                  theme.colorScheme.onPrimary,
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
              )),
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
        'email': confirmEmail.text,
        'handphone': handphone.text,
        'telephone': telephone.text,
        'profilePicture': null
      };
      final jsonString = json.encode(body);
      final uri = Uri.http(
          'chilamlol.pythonanywhere.com', '/account/update-profile/$userID');

      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.put(uri, headers: headers, body: jsonString);

      if (response.statusCode == 200) {
        var futureGetAlumni =
            GetAlumniState.fromJson(jsonDecode(response.body));

        prefs.setString('email', confirmEmail.text);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const otpVerification()),
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

  Future<void> getAlumniData() async {
    final prefs = await SharedPreferences.getInstance();
    final userID = prefs.getInt('userID') ?? 0;
    String token = prefs.getString('token') ?? " ";

    final uri =
        Uri.http('chilamlol.pythonanywhere.com', '/account/info/$userID');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'user-token': token
    };
    final response = await http.get(uri, headers: requestHeaders);

    if (response.statusCode == 200) {
      var futureGetAlumniData =
          GetAlumniDataState.fromJson(jsonDecode(response.body));

      email.text = futureGetAlumniData.personalEmail;
      handphone.text = futureGetAlumniData.studentHandphone;
      telephone.text = futureGetAlumniData.studentHandphone;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Server Error")));
    }
  }
}

class GetAlumniState {
  final String message;

  GetAlumniState({
    required this.message,
  });

  factory GetAlumniState.fromJson(Map<String, dynamic> json) {
    return GetAlumniState(message: json['message']);
  }
}

class GetAlumniDataState {
  final String personalEmail;
  final String studentHandphone;
  final String studentTelephoneNumber;

  GetAlumniDataState(
      {required this.personalEmail,
      required this.studentHandphone,
      required this.studentTelephoneNumber});

  factory GetAlumniDataState.fromJson(Map<String, dynamic> json) {
    return GetAlumniDataState(
      personalEmail: json['personalEmail'],
      studentHandphone: json['studentHandphone'],
      studentTelephoneNumber: json['studentTelephoneNumber'],
    );
  }
}
