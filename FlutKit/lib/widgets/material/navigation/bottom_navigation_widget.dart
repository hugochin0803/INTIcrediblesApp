/*
* File : Bottom Navigation widget
* Version : 1.0.0
* Description :
* */

import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;
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
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(FeatherIcons.chevronLeft, size: 20,),
        ),
        title: FxText.sh1("Bottom Navigation", fontWeight: 600),
      ),
      body: Center(
        child: _currentIndex == 0
            ? Icon(Icons.chat,
            color: theme.colorScheme.onBackground, size: 80)
            : Icon(Icons.call,
            color: theme.colorScheme.onBackground, size: 80),
      ),
      bottomNavigationBar: BottomNavigationBar(
        /*----------- Build Bottom Navigation Tab here ---------------*/
        currentIndex: _currentIndex,
        backgroundColor: customTheme.card,
        selectedIconTheme: IconThemeData(color: theme.primaryColor),
        selectedItemColor: theme.primaryColor,
        unselectedIconTheme:
        IconThemeData(color: theme.colorScheme.onBackground),
        unselectedItemColor: theme.colorScheme.onBackground,
        onTap: onTapped,
        items: [
          /*----------- Build Bottom Navigation Content here ---------------*/
          BottomNavigationBarItem(
              icon: new Icon(Icons.chat), label: 'CHAT'),
          BottomNavigationBarItem(
            icon: new Icon(Icons.call),
            label: 'CALL',
          )
        ],
      ),
    );
  }

  onTapped(value) {
    setState(() {
      _currentIndex = value;
    });
  }
}
