/*
* File : Navigation Drawer widget
* Version : 1.0.0
* Description :
* */

import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  int _selectedPage = 0;

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
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          title: FxText.h6("Drawer", fontWeight: 600),
        ),
        drawer: Drawer(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  /*---------- Drawer Header ----------------*/
                  Expanded(
                    flex: 2,
                    child: DrawerHeader(
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.all(0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, bottom: 8, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        new Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                image: AssetImage(
                                                    "./assets/images/profile/avatar-2.jpg"),
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                image: AssetImage(
                                                    "./assets/images/profile/avatar-1.jpg"),
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                        new Container(
                                          margin: EdgeInsets.only(left: 16),
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                image: AssetImage(
                                                    "./assets/images/profile/avatar.jpg"),
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  FxText.h6("Taslima Beattie",
                                      color: theme.colorScheme.onPrimary,
                                      fontWeight: 600),
                                  FxText.b2("tas@gmail.com",
                                      color: theme.colorScheme.onPrimary,
                                      fontWeight: 400)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(color: theme.primaryColor),
                    ),
                  ),

                  /*------------- Drawer Content -------------*/
                  Expanded(
                    flex: 6,
                    child: Container(
                      color: theme.backgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListView(
                          padding: EdgeInsets.all(0),
                          children: <Widget>[
                            singleDrawerItem(
                                MdiIcons.inbox, "All Inboxes", 0),
                            Divider(
                              height: 1,
                              color: theme.dividerColor,
                              thickness: 1,
                            ),
                            singleDrawerItem(
                                MdiIcons.emailOutline, "Primary", 1),
                            singleDrawerItem(
                                MdiIcons.accountGroupOutline, "Social", 2),
                            singleDrawerItem(
                                MdiIcons.tagOutline, "Promotion", 3),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 12, left: 16, right: 16, bottom: 12),
                              child: FxText.caption("ALL LABELS",
                                  color: theme.colorScheme.onBackground
                                      .withAlpha(240),
                                  fontWeight: 700,
                                  letterSpacing: 0.35,
                                  wordSpacing: 1.2),
                            ),
                            singleDrawerItem(
                                MdiIcons.starOutline, "Starred", 4),
                            singleDrawerItem(
                                MdiIcons.clockOutline, "Snoozed", 5),
                            singleDrawerItem(MdiIcons.send, "Sent", 6),
                            singleDrawerItem(
                                MdiIcons.fileOutline, "Drafts", 7),
                            singleDrawerItem(MdiIcons.emailMultipleOutline,
                                "All Mail", 8),
                            singleDrawerItem(
                                MdiIcons.alertOctagonOutline, "Spam", 9),
                            singleDrawerItem(
                                MdiIcons.trashCanOutline, "Bin", 10),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 12, left: 16, right: 16, bottom: 12),
                              child: FxText.caption("OTHER APPS",
                                  color: theme.colorScheme.onBackground
                                      .withAlpha(240),
                                  fontWeight: 700,
                                  letterSpacing: 0.35,
                                  wordSpacing: 1.2),
                            ),
                            singleDrawerItem(MdiIcons.calendarBlankOutline,
                                "Calender", 11),
                            singleDrawerItem(MdiIcons.accountCircleOutline,
                                "Contact", 12),
                            Divider(
                              height: 1,
                              color: theme.dividerColor,
                              thickness: 1,
                            ),
                            singleDrawerItem(
                                MdiIcons.wrenchOutline, "Settings", 13),
                            singleDrawerItem(MdiIcons.helpCircleOutline,
                                "Help and feedback", 14),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            MdiIcons.chevronLeft,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        body: Container(
          color: theme.backgroundColor,
        ));
  }

  Widget singleDrawerItem(IconData iconData, String title, int position) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(top: 0.0, left: 16, right: 16, bottom: 0),
      leading: Icon(iconData,
          size: 20,
          color: _selectedPage == position
              ? theme.colorScheme.primary
              : theme.colorScheme.onBackground.withAlpha(240)),
      title: FxText.sh2(title,
          fontWeight: _selectedPage == position ? 600 : 500,
          letterSpacing: 0.2,
          color: _selectedPage == position
              ? theme.colorScheme.primary
              : theme.colorScheme.onBackground.withAlpha(240)),
      onTap: () {
        setState(() {
          _selectedPage = position;
        });
        _scaffoldKey.currentState!.openEndDrawer();
      },
    );
  }

  void showSnackbarWithFloating(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: FxText.sh2(message, color: theme.colorScheme.onPrimary),
        backgroundColor: theme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
