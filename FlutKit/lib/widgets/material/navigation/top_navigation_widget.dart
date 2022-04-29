/*
* File : Top Navigation widget
* Version : 1.0.0
* Description :
* */

import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

class TopNavigationWidget extends StatefulWidget {
  @override
  _TopNavigationWidgetState createState() => _TopNavigationWidgetState();
}

class _TopNavigationWidgetState extends State<TopNavigationWidget> {
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
        title: FxText.sh1("Top Navigation", fontWeight: 600),
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: new Scaffold(
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /*-------------- Build Tabs here ------------------*/
                new TabBar(
                  tabs: [
                    Tab(child: FxText.sh1("Tab 1", fontWeight: 600)),
                    Tab(child: FxText.sh1("Tab 2", fontWeight: 600)),
                    Tab(child: FxText.sh1("Tab 3", fontWeight: 600)),
                  ],
                )
              ],
            ),
          ),

          /*--------------- Build Tab body here -------------------*/
          body: TabBarView(
            children: <Widget>[
              getTabContent('Tab 1'),
              getTabContent('Tab 2'),
              getTabContent('Tab 3')
            ],
          ),
        ),
      ),
    );
  }

  Widget getTabContent(String text) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Center(
        child: FxText.sh1(text, fontWeight: 600),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
