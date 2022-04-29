/*
* File : Edit Profile
* Version : 1.0.0
* */

import 'dart:convert';
import 'package:flutkit/screens/event/event_full_app.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;

    getAlumni();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FxText.sh1("Edit Profile",
              color: theme.colorScheme.onBackground, fontWeight: 600),
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              FeatherIcons.chevronLeft,
              size: 20,
              color: theme.colorScheme.onBackground,
            ),
          ),
          elevation: 0,
        ),
        body: SafeArea(
            child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(20),
                        width: 140,
                        height: 140,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  "./assets/images/profile/avatar-4.jpg"),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: theme.scaffoldBackgroundColor,
                                width: 2,
                                style: BorderStyle.solid),
                            color: theme.colorScheme.primary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              MdiIcons.pencil,
                              size: 20,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  FxText.h6(stname.text, fontWeight: 600, letterSpacing: 0),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        style: FxTextStyle.b1(
                            letterSpacing: 0.1,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500),
                        decoration: InputDecoration(
                          hintText: "Student ID",
                          hintStyle: FxTextStyle.sh2(
                              letterSpacing: 0.1,
                              color: theme.colorScheme.onBackground,
                              fontWeight: 500),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: customTheme.card,
                          prefixIcon: const Icon(
                            MdiIcons.accountOutline,
                          ),
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        controller: ststudentId,
                        textCapitalization: TextCapitalization.sentences,
                        readOnly: true,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        style: FxTextStyle.b1(
                            letterSpacing: 0.1,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500),
                        decoration: InputDecoration(
                          hintText: "Personal Email",
                          hintStyle: FxTextStyle.sh2(
                              letterSpacing: 0.1,
                              color: theme.colorScheme.onBackground,
                              fontWeight: 500),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: customTheme.card,
                          prefixIcon: const Icon(
                            MdiIcons.emailOutline,
                          ),
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: stpersonalEmail,
                        textCapitalization: TextCapitalization.sentences,
                        readOnly: true,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        style: FxTextStyle.b1(
                            letterSpacing: 0.1,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500),
                        decoration: InputDecoration(
                          hintText: "Student IC",
                          hintStyle: FxTextStyle.sh2(
                              letterSpacing: 0.1,
                              color: theme.colorScheme.onBackground,
                              fontWeight: 500),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: customTheme.card,
                          prefixIcon: const Icon(
                            MdiIcons.cardAccountDetails,
                          ),
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: stidentificationCard,
                        textCapitalization: TextCapitalization.sentences,
                        readOnly: true,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        style: FxTextStyle.b1(
                            letterSpacing: 0.1,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500),
                        decoration: InputDecoration(
                          hintText: "Student Handphone",
                          hintStyle: FxTextStyle.sh2(
                              letterSpacing: 0.1,
                              color: theme.colorScheme.onBackground,
                              fontWeight: 500),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: customTheme.card,
                          prefixIcon: const Icon(
                            MdiIcons.phone,
                          ),
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter handphone ';
                          }

                          if (value.length < 9) {
                            return 'Please enter correct format';
                          }

                          return null;
                        },
                        controller: ststudentHandphone,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        style: FxTextStyle.b1(
                            letterSpacing: 0.1,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500),
                        decoration: InputDecoration(
                          hintText: "Student Telephone",
                          hintStyle: FxTextStyle.sh2(
                              letterSpacing: 0.1,
                              color: theme.colorScheme.onBackground,
                              fontWeight: 500),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: customTheme.card,
                          prefixIcon: const Icon(
                            MdiIcons.phoneClassic,
                          ),
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter telephone ';
                          }

                          if (value.length < 9) {
                            return 'Please enter correct format';
                          }

                          return null;
                        },
                        textCapitalization: TextCapitalization.sentences,
                        controller: ststudentTelephoneNumber,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      child: FxButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              updateProfile();
                            }
                          },
                          borderRadiusAll: 4,
                          elevation: 0,
                          child: FxText.button("UPDATE",
                              fontWeight: 600,
                              color: theme.colorScheme.onPrimary,
                              letterSpacing: 0.3)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )));
  }

  Future<void> getAlumni() async {
    final prefs = await SharedPreferences.getInstance();
    final userID = prefs.getInt('userID') ?? 0;
    String token = prefs.getString('token') ?? " ";
    final uri = Uri.http('chilamlol.pythonanywhere.com', '/alumni/$userID');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'user-token': token
    };
    final response = await http.get(uri, headers: requestHeaders);

    var futureGetAlumni = GetAlumniState.fromJson(jsonDecode(response.body));

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

  Future<void> updateProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? " ";

    if (ststudentHandphone.text.isNotEmpty &&
        ststudentTelephoneNumber.text.isNotEmpty) {
// Try reading data from the counter key. If it doesn't exist, return 0.
      final alumniID = stalumniId.text;
      final body = {
        "graduatedProgrammeName": stgraduatedProgrammeName.text,
        "graduatingCampus": stgraduatingCampus.text,
        "graduatingProgramme": stgraduatingProgramme.text,
        "identificationCard": stidentificationCard.text,
        "levelOfStudy": stlevelOfStudy.text,
        "name": stname.text,
        "personalEmail": stpersonalEmail.text,
        "studentHandphone": ststudentHandphone.text,
        "studentId": ststudentId.text,
        "studentTelephoneNumber": ststudentTelephoneNumber.text,
        "yearOfGraduation": styearOfGraduation.text
      };
      final jsonString = json.encode(body);
      final uri =
          Uri.http('chilamlol.pythonanywhere.com', '/alumni/update/$alumniID');
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'user-token': token
      };
      final response =
          await http.put(uri, headers: requestHeaders, body: jsonString);

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventFullApp()),
        );
      } else if (response.statusCode == 404) {
        //same data
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventFullApp()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "There is an issue on our end! Please contact admin for assistance!")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Blank Field Not Allowed")));
    }
  }
}

class GetAlumniState {
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

  GetAlumniState({
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

  factory GetAlumniState.fromJson(Map<String, dynamic> json) {
    return GetAlumniState(
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

class UpdateAlumniState {
  final String message;
  final String error;

  UpdateAlumniState({
    this.message = "",
    this.error = "",
  });

  factory UpdateAlumniState.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      return UpdateAlumniState(message: json['message']);
    } else {
      return UpdateAlumniState(error: json['error']);
    }
  }
}
