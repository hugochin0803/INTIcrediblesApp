/*
* File : Login
* Version : 1.0.0
* */

import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:flutkit/screens/event/event_full_app.dart';

// ignore: camel_case_types
class otpSuccess extends StatefulWidget {
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
    return Scaffold(
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
                      child: FxText.h6(
                        "OTP Verification Success",
                        fontWeight: 800,
                        fontSize: 25,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 0, top: 10),
                      child: FxText.h6("Verification Successful!",
                          fontWeight: 400, fontSize: 16),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30, top: 0),
                      child: FxText.h6("Please proceed to home page",
                          fontWeight: 400, fontSize: 16),
                    ),
                    Container(
                      height: 120.0,
                      width: 170.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/all/otpsuccess.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, left: 12, right: 12),
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
