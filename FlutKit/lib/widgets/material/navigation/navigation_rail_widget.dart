/*
* File : Navigation Rail widget
* Version : 1.0.0
* Description :
* */

import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavigationRailWidget extends StatefulWidget {
  @override
  _NavigationRailWidgetState createState() => _NavigationRailWidgetState();
}

class _NavigationRailWidgetState extends State<NavigationRailWidget> {
  int _selectedIndex = 0;

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
      body: Padding(
        padding: FxSpacing.top(FxSpacing.safeAreaTop(context)),
        child: Row(
          children: <Widget>[
            NavigationRail(
              backgroundColor: customTheme.card,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  MdiIcons.chevronLeft,
                  color: theme.colorScheme.onBackground,
                ),
              ),
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.selected,
              /*------------- Build Tabs -------------------*/
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.favorite_border),
                  selectedIcon: Icon(Icons.favorite),
                  label: FxText.b1('First',
                      fontWeight: 700,
                      color: theme.colorScheme.primary),
                ),
                NavigationRailDestination(
                  icon: Icon(MdiIcons.bookOutline),
                  selectedIcon: Icon(MdiIcons.book),
                  label: FxText.b1('Second',
                      fontWeight: 700,
                      color: theme.colorScheme.primary),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.star_border),
                  selectedIcon: Icon(Icons.star),
                  label: FxText.b1('Third',
                      fontWeight: 700,
                      color: theme.colorScheme.primary),
                ),
              ],
            ),

            // This is the main content.
            Expanded(
              child: Center(
                child: FxText.sh1('Selected : $_selectedIndex',
                    color: theme.colorScheme.onBackground,
                    letterSpacing: 0.3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
