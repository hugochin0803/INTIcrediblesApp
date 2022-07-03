/*
* File : Login
* Version : 1.0.0
* */

import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutkit/screens/event/event_full_app.dart';

// ignore: camel_case_types
class otpSuccess extends StatefulWidget {
  const otpSuccess({Key? key}) : super(key: key);

  @override
  _otpSuccess createState() => _otpSuccess();
}

// ignore: camel_case_types
class _otpSuccess extends State<otpSuccess> {
  // bool? _passwordVisible = false, _check = false;
  late CustomTheme customTheme;
  late ThemeData theme;

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
                            margin: const EdgeInsets.fromLTRB(10, 1, 10, 8),
                            child: FxText.h6(
                              "OTP Verification Success",
                              fontWeight: 800,
                              fontSize: 25,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 0, top: 10),
                            child: FxText.h6("Verification Successful!",
                                fontWeight: 400, fontSize: 16),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 30, top: 0),
                            child: FxText.h6("Please proceed to home page",
                                fontWeight: 400, fontSize: 16),
                          ),
                          Container(
                            height: 120.0,
                            width: 170.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/all/otpsuccess.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 16, left: 12, right: 12),
                            child: FxButton.block(
                                elevation: 0,
                                borderRadiusAll: 4,
                                padding: FxSpacing.y(12),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EventFullApp()),
                                  );
                                },
                                child: FxText.button("Proceed",
                                    fontWeight: 600,
                                    color: theme.colorScheme.onPrimary,
                                    letterSpacing: 0.5)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
