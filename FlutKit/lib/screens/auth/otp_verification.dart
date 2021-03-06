/*
* File : Login
* Version : 1.0.0
* */

import 'dart:convert';
import 'dart:io';

import 'package:flutkit/screens/auth/otp_success.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutkit/screens/auth/reset_password.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class otpVerification extends StatefulWidget {
  const otpVerification({Key? key}) : super(key: key);

  @override
  _otpVerification createState() => _otpVerification();
}

// ignore: camel_case_types
class _otpVerification extends State<otpVerification> {
  late CustomTheme customTheme;
  late ThemeData theme;
  var otp = TextEditingController();
  String email = "";

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    loademail();
    getAlumni();
  }

  void loademail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getBool('forgotPassword') == true) {
        email = prefs.getString('resetEmail') ?? "";
      } else {
        email = prefs.getString('email') ?? "";
      }
    });
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
              top: MediaQuery.of(context).size.height * 0.15,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  FxContainer.bordered(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    color: theme.scaffoldBackgroundColor,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 1, top: 8),
                          child: FxText.h6("OTP Verification",
                              fontWeight: 800, fontSize: 25),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          child: FxText.h6("The OTP will send to below email:",
                              fontWeight: 400, fontSize: 16),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 30, top: 0),
                          child:
                              FxText.h6(email, fontWeight: 400, fontSize: 16),
                        ),
                        Container(
                          height: 120.0,
                          width: 170.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/all/otpmail.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: FxTextStyle.b1(
                                    letterSpacing: 0.1,
                                    color: theme.colorScheme.onBackground,
                                    fontWeight: 500),
                                keyboardType: TextInputType.number,
                                controller: otp,
                                decoration: InputDecoration(
                                  hintText: "OTP",
                                  hintStyle: FxTextStyle.sh2(
                                      letterSpacing: 0.1,
                                      color: theme.colorScheme.onBackground,
                                      fontWeight: 500),
                                  prefixIcon:
                                      const Icon(MdiIcons.numeric0BoxMultiple),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                alignment: Alignment.centerRight,
                                child: FxButton.text(
                                  elevation: 0,
                                  borderRadiusAll: 4,
                                  padding: FxSpacing.y(12),
                                  onPressed: () {
                                    getAlumni();
                                  },
                                  child:
                                      FxText.b2("Resend OTP", fontWeight: 500),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 2, top: 30),
                                child: FxText.h6(
                                  "Please check your email and enter the OTP",
                                  fontWeight: 400,
                                  fontSize: 16,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                child: FxButton.block(
                                    elevation: 0,
                                    borderRadiusAll: 4,
                                    padding: FxSpacing.y(12),
                                    onPressed: () {
                                      otpVerify();
                                    },
                                    child: FxText.button("SUBMIT",
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
        ));
  }

  Future<void> otpVerify() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = "";
    final flag = prefs.getBool('forgotPassword') ?? false;
    if (flag == true) {
      email = prefs.getString('resetEmail') ?? "";

      final body = {'otp': int.parse(otp.text)};
      final jsonString = json.encode(body);
      final uri =
          Uri.http('chilamlol.pythonanywhere.com', '/OTPService/verify/$email');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.post(uri, headers: headers, body: jsonString);
      if (response.statusCode == 200) {
        var futureGetAlumni = GetOTPState.fromJson(jsonDecode(response.body));

        if (futureGetAlumni.otpVerify == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => resetPassword()),
          );
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Invalid OTP!")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Invalid OTP!")));
      }
    } else {
      if (otp.text.isNotEmpty) {
        final email = prefs.getString('email') ?? "";
        final body = {'otp': int.parse(otp.text)};
        final jsonString = json.encode(body);
        final uri = Uri.http(
            'chilamlol.pythonanywhere.com', '/OTPService/verify/$email');
        final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
        final response =
            await http.post(uri, headers: headers, body: jsonString);

        if (response.statusCode == 200) {
          var futureGetAlumni = GetOTPState.fromJson(jsonDecode(response.body));

          if (futureGetAlumni.otpVerify == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const otpSuccess()),
            );
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Invalid OTP!")));
          }
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

Future<void> getAlumni() async {
  final prefs = await SharedPreferences.getInstance();
  // Try reading data from the counter key. If it doesn't exist, return 0.

  String email = "";
  if (prefs.getBool('forgotPassword') == true) {
    email = prefs.getString('resetEmail') ?? "";
  } else {
    email = prefs.getString('email') ?? "";
  }

  final uri =
      Uri.http('chilamlol.pythonanywhere.com', '/OTPService/send/$email');
  final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
  await http.get(uri, headers: headers);
}

class GetOTPState {
  final int otpVerify;

  GetOTPState({
    required this.otpVerify,
  });

  factory GetOTPState.fromJson(Map<String, dynamic> json) {
    return GetOTPState(otpVerify: json['otpVerify']);
  }
}
