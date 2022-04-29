/*
* File : Searchbar widget
* Version : 1.0.0
* */

import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
      backgroundColor: theme.scaffoldBackgroundColor,
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(MdiIcons.chevronLeft),
      ),
      /*---------------Navigation Drawer ------------------*/
      drawer: Drawer(
          child: Container(
            color: theme.backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: 0.0, left: 16, right: 16, bottom: 12),
                  child: Container(
                    margin: EdgeInsets.only(top: 36),
                    child: FxText.h6("Mail",
                        color: theme.colorScheme.primary, letterSpacing: 0.2),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Divider(
                              height: 1,
                              color: theme.dividerColor,
                              thickness: 1,
                            ),
                            singleDrawerItem(MdiIcons.inbox, "All Inboxes", 0),
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
                            singleDrawerItem(MdiIcons.fileOutline, "Drafts", 7),
                            singleDrawerItem(
                                MdiIcons.emailMultipleOutline, "All Mail", 8),
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
                            singleDrawerItem(
                                MdiIcons.calendarBlankOutline, "Calender", 11),
                            singleDrawerItem(
                                MdiIcons.accountCircleOutline, "Contact", 12),
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
                  ),
                )
              ],
            ),
          )),
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            // Replace this container with your Map widget
            Container(
              child: Center(
                child: FxText.sh2("Content place here",
                    color: theme.colorScheme.onBackground.withAlpha(240),
                    letterSpacing: 0.2),
              ),
            ),
            Positioned(
              top: 40,
              right: 16,
              left: 16,
              child: FxContainer(
                padding: EdgeInsets.only(
                    left: 12, top: 8, right: 12, bottom: 8),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        child: Icon(
                          MdiIcons.menu,
                          size: 24,
                          color: theme.colorScheme.onBackground
                              .withAlpha(240),
                        )),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 8),
                        child: Container(
                          child: FxTextField(
                            decoration: InputDecoration(
                                hintText: "Search here",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                isDense: true),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: theme.colorScheme.secondary,
                      child: FxText.sh2("D",
                          color: theme.colorScheme.onSecondary),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
          fontWeight: _selectedPage == position ? 700 : 600,
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
}
