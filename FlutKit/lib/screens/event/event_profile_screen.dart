import 'dart:developer';
import 'dart:io';

import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutkit/screens/auth/login_screen.dart';
import 'package:flutkit/screens/event/edit_profile_screen.dart';
import 'package:flutkit/screens/other/faq_question_screen.dart';
import 'package:flutkit/screens/other/about_app_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class EventProfileScreen extends StatefulWidget {
  @override
  _EventProfileScreenState createState() => _EventProfileScreenState();
}

class _EventProfileScreenState extends State<EventProfileScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  double lat = 3.0746710731221096;
  double long = 101.59192857639037;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FxText.bodyLarge("Profile Setting",
              color: theme.colorScheme.onPrimary, fontWeight: 600),
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              FeatherIcons.chevronLeft,
              size: 20,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          elevation: 0,
          backgroundColor: theme.colorScheme.primary,
        ),
        body: ListView(
          padding: FxSpacing.fromLTRB(20, 0, 20, 20),
          children: <Widget>[
            Container(
              margin: FxSpacing.top(20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        color: theme.colorScheme.primary),
                    padding: FxSpacing.all(10),
                    child: Icon(
                      MdiIcons.tuneVariant,
                      size: 20,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText.b2("Account",
                          color: theme.colorScheme.onBackground,
                          fontWeight: 700),
                      FxText.overline("Edit and manage your account details",
                          color: theme.colorScheme.onBackground,
                          letterSpacing: 0,
                          muted: true,
                          fontWeight: 600)
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: FxSpacing.top(20),
              padding: FxSpacing.vertical(8),
              decoration: BoxDecoration(
                color: customTheme.card,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen()),
                      );
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.sh2("Edit Profile",
                            color: theme.colorScheme.onBackground,
                            fontWeight: 700),
                      ],
                    ),
                    trailing: Icon(
                      MdiIcons.chevronRight,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
            Container(
              margin: FxSpacing.top(20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: theme.colorScheme.primary),
                    padding: FxSpacing.all(10),
                    child: Icon(
                      MdiIcons.emailOpenOutline,
                      size: 20,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText.b2("Help and Feedback",
                          color: theme.colorScheme.onBackground,
                          fontWeight: 700),
                      FxText.overline(
                          "Reach us with your feedback and questions",
                          color: theme.colorScheme.onBackground,
                          letterSpacing: 0,
                          muted: true,
                          fontWeight: 600)
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: FxSpacing.top(20),
              padding: FxSpacing.vertical(8),
              decoration: BoxDecoration(
                color: customTheme.card,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      MdiIcons.frequentlyAskedQuestions,
                      color: theme.colorScheme.onBackground,
                    ),
                    title: FxText.b1("FAQs",
                        color: theme.colorScheme.onBackground, fontWeight: 600),
                    trailing: Icon(
                      MdiIcons.chevronRight,
                      color: theme.colorScheme.onBackground,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FAQQuestionScreen()),
                      );
                    },
                  ),
                  Divider(
                    height: 0,
                  ),
                  ListTile(
                    leading: Icon(
                      MdiIcons.accountGroupOutline,
                      color: theme.colorScheme.onBackground,
                    ),
                    title: FxText.b1("About Us",
                        color: theme.colorScheme.onBackground, fontWeight: 600),
                    trailing: Icon(
                      MdiIcons.chevronRight,
                      color: theme.colorScheme.onBackground,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AboutAppScreen()),
                      );
                    },
                  ),
                  Divider(
                    height: 0,
                  ),
                  ListTile(
                      leading: Icon(
                        MdiIcons.emailOutline,
                        color: theme.colorScheme.onBackground,
                      ),
                      title: FxText.b1("Contact Us",
                          color: theme.colorScheme.onBackground,
                          fontWeight: 600),
                      trailing: Icon(
                        MdiIcons.chevronRight,
                        color: theme.colorScheme.onBackground,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                  Positioned(
                                    right: -40.0,
                                    top: -40.0,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: CircleAvatar(
                                        child: Icon(Icons.close),
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        margin: FxSpacing.top(20),
                                        padding: FxSpacing.vertical(8),
                                        decoration: BoxDecoration(
                                          color: customTheme.card,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              onTap: () async {
                                                openwhatsapp();
                                              },
                                              leading: Icon(
                                                MdiIcons.whatsapp,
                                                color: theme
                                                    .colorScheme.onBackground,
                                              ),
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  FxText.sh2("WhatsAPP",
                                                      color: theme.colorScheme
                                                          .onBackground,
                                                      fontWeight: 700),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Divider(
                                              height: 0,
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                MdiIcons.emailOutline,
                                                color: theme
                                                    .colorScheme.onBackground,
                                              ),
                                              title: FxText.b1("Email",
                                                  color: theme
                                                      .colorScheme.onBackground,
                                                  fontWeight: 600),
                                              onTap: () {
                                                openemail();
                                              },
                                            ),
                                            Divider(
                                              height: 0,
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                MdiIcons.bankOutline,
                                                color: theme
                                                    .colorScheme.onBackground,
                                              ),
                                              title: FxText.b1("Address",
                                                  color: theme
                                                      .colorScheme.onBackground,
                                                  fontWeight: 600),
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        content: Stack(
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: <Widget>[
                                                            Positioned(
                                                              right: -40.0,
                                                              top: -40.0,
                                                              child:
                                                                  InkResponse(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  child: Icon(
                                                                      Icons
                                                                          .close),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                ),
                                                              ),
                                                            ),
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  child: FxText.h4(
                                                                      "Address:",
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          700,
                                                                      letterSpacing:
                                                                          -1,
                                                                      color: theme
                                                                          .colorScheme
                                                                          .onBackground),
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          10),
                                                                  child:
                                                                      Container(
                                                                    child: Column(
                                                                        children: <
                                                                            Widget>[
                                                                          FxText.bodySmall(
                                                                              "INTI Career Services, Ground Floor, Block C , No.3 Jalan SS15/8,47500 Subang Jaya, Selangor, Malaysia",
                                                                              fontSize: 16,
                                                                              fontWeight: 500,
                                                                              letterSpacing: -1,
                                                                              color: theme.colorScheme.onBackground),
                                                                          Container(
                                                                            margin:
                                                                                const EdgeInsets.only(top: 5),
                                                                            child: FxButton.block(
                                                                                elevation: 0,
                                                                                borderRadiusAll: 4,
                                                                                padding: FxSpacing.y(12),
                                                                                onPressed: () {
                                                                                  _showBottomSheet(context);
                                                                                },
                                                                                child: FxText.button("Location", fontWeight: 600, color: theme.colorScheme.onPrimary, letterSpacing: 0.5)),
                                                                          ),
                                                                        ]),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              },
                                              onLongPress: () {},
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: FxButton.block(
                  elevation: 0,
                  borderRadiusAll: 4,
                  padding: FxSpacing.y(12),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('userID');
                    prefs.remove('token');
                    prefs.remove('isLoggedIn');
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Login2Screen()),
                        (Route<dynamic> route) => false);
                  },
                  child: FxText.button("Logout",
                      fontWeight: 600,
                      color: theme.colorScheme.onPrimary,
                      letterSpacing: 0.5)),
            ),
          ],
        ));
  }

  openwhatsapp() async {
    var whatsapp = "+60123853230";
    var whatappURL = "https://wa.me/$whatsapp";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL)) {
        await launch(whatappURL, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatappURL)) {
        await launch(whatappURL);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }

  openemail() async {
    String email = 'alumni@newinti.edu.my';

    // String? encodeQueryParameters(Map<String, String> params) {
    //   return params.entries
    //       .map((e) =>
    //           '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
    //       .join('&');
    // }

    final Uri emailUri = Uri(scheme: 'mailto', path: email);

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("Email not supported")));
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            decoration: BoxDecoration(
                color: theme.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: Padding(
              padding: FxSpacing.fromLTRB(24, 24, 24, 36),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(Icons.supervisor_account_outlined,
                              size: 26, color: theme.colorScheme.onBackground),
                          Container(
                              margin: FxSpacing.top(4),
                              child: FxButton.text(
                                  onPressed: () {
                                    launchWaze(lat, long);
                                  },
                                  child: FxText.bodyMedium("Waze",
                                      letterSpacing: 0.1,
                                      color: theme.colorScheme.primary,
                                      fontWeight: 700))),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(Icons.supervisor_account_outlined,
                              size: 26, color: theme.colorScheme.onBackground),
                          Container(
                              margin: FxSpacing.top(4),
                              child: FxButton.text(
                                  onPressed: () {
                                    launchGoogleMaps(lat, long);
                                  },
                                  child: FxText.bodyMedium("Google Map",
                                      letterSpacing: 0.1,
                                      color: theme.colorScheme.primary,
                                      fontWeight: 700)))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> launchWaze(double lat, double long) async {
    var url = 'waze://?ll=${lat.toString()},${long.toString()}';
    var fallbackUrl =
        'https://waze.com/ul?ll=${lat.toString()},${long.toString()}&navigate=yes';
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  Future<void> launchGoogleMaps(double lat, double long) async {
    var url = 'google.navigation:q=${lat.toString()},${long.toString()}';
    var fallbackUrl =
        'https://www.google.com/maps/search/?api=1&query=${lat.toString()},${long.toString()}';
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }
}
