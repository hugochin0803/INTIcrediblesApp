/*
* File : Custom Bottom Navigation widget
* Version : 1.0.0
* Description :
* */

import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/widgets/custom/navigation/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

class CustomBottomNavigationWidget extends StatefulWidget {
  @override
  _CustomBottomNavigationWidgetState createState() =>
      _CustomBottomNavigationWidgetState();
}

class _CustomBottomNavigationWidgetState
    extends State<CustomBottomNavigationWidget> {
  int _currentIndex = 0;
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  PageController? _pageController;

  late NavigationTheme navigationTheme = NavigationTheme.getNavigationTheme();

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
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
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            /*-------------- Build tab content here -----------------*/
            Container(
              child: Center(
                child: FxText.sh2("Item 1", fontWeight: 600),
              ),
            ),
            Container(
              child: Center(
                child: FxText.sh2("Item 2", fontWeight: 600),
              ),
            ),
            Container(
              child: Center(
                child: FxText.sh2("Item 3", fontWeight: 600),
              ),
            ),
            Container(
              child: Center(
                child: FxText.sh2("Item 4", fontWeight: 600),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        animationDuration: Duration(milliseconds: 350),
        selectedItemOverlayColor: navigationTheme.selectedOverlayColor,
        backgroundColor: navigationTheme.backgroundColor,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController!.jumpToPage(index);
        },
        items: <CustomBottomNavigationBarItem>[
          /*-------------- Build tabs here -----------------*/
          CustomBottomNavigationBarItem(
              title: 'Item One',
              icon: Icon(Icons.home),
              activeColor: navigationTheme.selectedItemColor,
              inactiveColor: navigationTheme.unselectedItemColor),
          CustomBottomNavigationBarItem(
              title: 'Item Two',
              icon: Icon(Icons.apps),
              activeColor: navigationTheme.selectedItemColor,
              inactiveColor: navigationTheme.unselectedItemColor),
          CustomBottomNavigationBarItem(
              title: 'Item Three',
              icon: Icon(Icons.chat_bubble),
              activeColor: navigationTheme.selectedItemColor,
              inactiveColor: navigationTheme.unselectedItemColor),
          CustomBottomNavigationBarItem(
              title: 'Item Four',
              icon: Icon(Icons.settings),
              activeColor: navigationTheme.selectedItemColor,
              inactiveColor: navigationTheme.unselectedItemColor),
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
