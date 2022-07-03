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

import '../event/event_full_app.dart';

// ignore: camel_case_types
class resetEmail2 extends StatefulWidget {
  const resetEmail2({Key? key}) : super(key: key);

  @override
  _resetEmail2 createState() => _resetEmail2();
}

// ignore: camel_case_types
class _resetEmail2 extends State<resetEmail2> {
  // bool? _passwordVisible = false, _check = false;
  late CustomTheme customTheme;
  late ThemeData theme;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var stname = TextEditingController();
  var stalumniId = TextEditingController();
  var stgraduatedProgrammeName = TextEditingController();
  var stgraduatingCampus = TextEditingController();
  var stgraduatingProgramme = TextEditingController();
  var stidentificationCard = TextEditingController();
  var stlevelOfStudy = TextEditingController();
  var stpersonalEmail = TextEditingController();
  var ststudentHandphone = TextEditingController();
  var ststudentId = TextEditingController();
  var ststudentTelephoneNumber = TextEditingController();
  var styearOfGraduation = TextEditingController();

  var email = TextEditingController();
  var confirmEmail = TextEditingController();

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
                            child: FxText.h6("Reset Email",
                                fontWeight: 800, fontSize: 25),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10, top: 0),
                            child: FxText.h6("Please enter your new email here",
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
                                      child: FxButton.block(
                                          elevation: 0,
                                          borderRadiusAll: 4,
                                          padding: FxSpacing.y(12),
                                          onPressed: () {
                                            if (_formkey.currentState!
                                                .validate()) {
                                              updateProfile();
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
              ),
            )));
  }

  Future<void> updateProfile() async {
    if (email.text.isNotEmpty &&
        confirmEmail.text.isNotEmpty &&
        ststudentHandphone.text.isNotEmpty &&
        ststudentTelephoneNumber.text.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
      final userID = prefs.getInt('userID') ?? 0;
      final body = {
        'email': confirmEmail.text,
        'handphone': ststudentHandphone.text,
        'telephone': ststudentTelephoneNumber.text,
        'profilePicture': ""
      };
      final jsonString = json.encode(body);
      final uri = Uri.http(
          'chilamlol.pythonanywhere.com', '/account/update-profile/$userID');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.put(uri, headers: headers, body: jsonString);

      if (response.statusCode == 200) {
        var futureGetAlumni =
            GetAlumniState.fromJson(jsonDecode(response.body));

        prefs.setString('resetEmail', confirmEmail.text);
        prefs.setBool('changeEmail', true);
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
    final alumniID = prefs.getInt('alumniID') ?? 0;
    String token = prefs.getString('token') ?? " ";
    final uri = Uri.http('chilamlol.pythonanywhere.com', '/alumni/$alumniID');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'user-token': token
    };
    final response = await http.get(uri, headers: requestHeaders);

    var futureGetAlumni =
        GetAlumniDataState.fromJson(jsonDecode(response.body));

    stname.text = futureGetAlumni.name;
    stalumniId.text = futureGetAlumni.alumniId.toString();
    stgraduatedProgrammeName.text = futureGetAlumni.graduatedProgrammeName;
    stgraduatingCampus.text = futureGetAlumni.graduatingCampus;
    stgraduatingProgramme.text = futureGetAlumni.graduatingProgramme;
    stidentificationCard.text = futureGetAlumni.identificationCard;
    stlevelOfStudy.text = futureGetAlumni.levelOfStudy;
    stpersonalEmail.text = futureGetAlumni.personalEmail;
    ststudentHandphone.text = futureGetAlumni.studentHandphone;
    ststudentId.text = futureGetAlumni.studentId;
    ststudentTelephoneNumber.text = futureGetAlumni.studentTelephoneNumber;
    styearOfGraduation.text = futureGetAlumni.yearOfGraduation;
    setState(() {});
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
  final int alumniId;
  final String graduatedProgrammeName;
  final String graduatingCampus;
  final String graduatingProgramme;
  final String identificationCard;
  final String levelOfStudy;
  final String name;
  final String personalEmail;
  final String studentHandphone;
  final String studentId;
  final String studentTelephoneNumber;
  final String yearOfGraduation;

  GetAlumniDataState({
    required this.alumniId,
    required this.graduatedProgrammeName,
    required this.graduatingCampus,
    required this.graduatingProgramme,
    required this.identificationCard,
    required this.levelOfStudy,
    required this.name,
    required this.personalEmail,
    required this.studentHandphone,
    required this.studentId,
    required this.studentTelephoneNumber,
    required this.yearOfGraduation,
  });

  factory GetAlumniDataState.fromJson(Map<String, dynamic> json) {
    return GetAlumniDataState(
        alumniId: json['alumniId'],
        graduatedProgrammeName: json['graduatedProgrammeName'],
        graduatingCampus: json['graduatingCampus'],
        graduatingProgramme: json['graduatingProgramme'],
        identificationCard: json['identificationCard'],
        levelOfStudy: json['levelOfStudy'],
        name: json['name'],
        personalEmail: json['personalEmail'],
        studentHandphone: json['studentHandphone'],
        studentId: json['studentId'],
        studentTelephoneNumber: json['studentTelephoneNumber'],
        yearOfGraduation: json['yearOfGraduation']);
  }
}
