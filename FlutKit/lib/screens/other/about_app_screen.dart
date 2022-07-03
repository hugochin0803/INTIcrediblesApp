import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

class AboutAppScreen extends StatefulWidget {
  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                FeatherIcons.chevronLeft,
                size: 20,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            elevation: 4,
            backgroundColor: const Color(0xFFEC3E37),
            automaticallyImplyLeading: false,
            shadowColor: Colors.grey,
            title: Container(
                child: Row(children: <Widget>[
              FxText.bodyLarge(
                "About Us",
                color: theme.colorScheme.onPrimary,
                fontWeight: 600,
                fontSize: 18,
              ),
            ]))),
        backgroundColor: theme.backgroundColor,
        body: Container(
          child: ListView(
            padding: EdgeInsets.only(top: 20, left: 24, right: 24),
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                                "./assets/images/profile/INTIAU.jpg"),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FxText.sh1("INTI Alumni Unit",
                              fontWeight: 600,
                              color: theme.colorScheme.onBackground),
                          // Container(
                          //   child: FxText.sh2("hi",
                          //       fontWeight: 500,
                          //       color: theme.colorScheme.onBackground),
                          // ),
                        ],
                      ),
                    ),
                    // Expanded(
                    //   child: Align(
                    //     alignment: Alignment.topRight,
                    //     child: Container(
                    //       padding: EdgeInsets.only(
                    //           left: 8, right: 8, top: 4, bottom: 4),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.all(Radius.circular(4)),
                    //         color: theme.colorScheme.primary,
                    //       ),
                    //       child: FxText.caption("v 7.0.0",
                    //           fontSize: 11,
                    //           color: theme.colorScheme.onPrimary,
                    //           fontWeight: 600,
                    //           letterSpacing: 0.3),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: FxText.b1(
                    "Establish lifelong relationship between INTI and alumni holistically through networking, building and enriching for life.",
                    fontSize: 16,
                    fontWeight: 500,
                    color: theme.colorScheme.onBackground),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: FxText.b2(
                  "Our Mission",
                  fontSize: 16,
                  fontWeight: 700,
                  color: theme.colorScheme.onBackground,
                  decoration: TextDecoration.underline,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: FxText.b2(
                  "1. To strengthen ties between INTI and provide unique INTI alumni experience.",
                  fontSize: 16,
                  fontWeight: 500,
                  color: theme.colorScheme.onBackground,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: FxText.b2(
                    "2. To provide a platform to INTI alumni for network opportunities among alumni, INTI academic, current students and industry partners.",
                    fontSize: 16,
                    fontWeight: 500,
                    color: theme.colorScheme.onBackground),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: FxText.b2(
                    "3. To promote and instill interest of learning for further development of INTI alumni.",
                    fontSize: 16,
                    fontWeight: 500,
                    color: theme.colorScheme.onBackground),
              ),
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 20),
                child: FxText.b2(
                    "4. To enable alumni in contributing to the enrichment of INTI and community.",
                    fontSize: 16,
                    fontWeight: 500,
                    color: theme.colorScheme.onBackground),
              ),
            ],
          ),
        ));
  }
}
