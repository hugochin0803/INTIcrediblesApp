import 'package:flutkit/screens/reward/reward_detail.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/screens/event/event_ticket_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:provider/provider.dart';
import 'package:flutkit/theme/app_notifier.dart';

import '../../utils/generator.dart';

class RewardMarketplaceScreen extends StatefulWidget {
  const RewardMarketplaceScreen({Key? key}) : super(key: key);

  @override
  _RewardMarketplaceScreen createState() => _RewardMarketplaceScreen();
}

class _RewardMarketplaceScreen extends State<RewardMarketplaceScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    final subProvider = Provider.of<AppNotifier>(context, listen: false);
    subProvider.callEvent90API();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  int selectedCategory = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        automaticallyImplyLeading: false,
        title: FxText.sh1("Loyalty & Reward",
            color: theme.colorScheme.onPrimary, fontWeight: 600),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /*-------------- Build Tabs here ------------------*/
                TabBar(
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                    width: 3,
                    color: theme.colorScheme.primary,
                  )),
                  tabs: [
                    Tab(
                        child:
                            FxText.titleMedium("Marketplace", fontWeight: 600)),
                    Tab(child: FxText.titleMedium("Wallet", fontWeight: 600))
                  ],
                )
              ],
            ),
          ),

          /*--------------- Build Tab body here -------------------*/
          body: TabBarView(
            children: <Widget>[
              getTabContent1(context),
              getTabContent2(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget getTabContent1(BuildContext context) {
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: RefreshIndicator(
            backgroundColor: theme.backgroundColor,
            onRefresh: () async {},
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: _ProductListWidget(
                      name:
                          "Get 1pc Chicken(Ori/Spicier Spicy), 1pc Honey-Butter",
                      image: './assets/images/all/texas.png',
                      shopName: 'Texas Chicken',
                      star: 4.5,
                      price: 12000,
                      buildContext: context,
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: _ProductListWidget(
                    name: "Get FREE Frappuccino Blended Beverage",
                    image: './assets/images/all/starbucks.png',
                    shopName: 'Startbucks',
                    star: 3.8,
                    price: 14780,
                    buildContext: context,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: _ProductListWidget(
                    name: "10% off for one junior scoop of ice-cream",
                    image: './assets/images/all/kennyrogers.png',
                    shopName: 'Baskin-Robbins',
                    buildContext: context,
                    star: 4,
                    price: 15000,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: _ProductListWidget(
                    name: "20% off a drink worth RM7",
                    image: './assets/images/all/tealive.jpg',
                    shopName: 'Tealive',
                    buildContext: context,
                    star: 5,
                    price: 12500,
                  ),
                ),
              ],
            ))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget getTabContent2(BuildContext context) {
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: RefreshIndicator(
            backgroundColor: theme.backgroundColor,
            onRefresh: () async {},
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: _ProductListWidget(
                      name:
                          "Get 1pc Chicken(Ori/Spicier Spicy), 1pc Honey-Butter",
                      image: './assets/images/all/texas.png',
                      shopName: 'Texas Chicken',
                      star: 4.5,
                      price: 12000,
                      buildContext: context,
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: _ProductListWidget(
                    name: "Get FREE Frappuccino Blended Beverage",
                    image: './assets/images/all/starbucks.png',
                    shopName: 'Startbucks',
                    star: 3.8,
                    price: 14780,
                    buildContext: context,
                  ),
                ),
              ],
            ))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class _ProductListWidget extends StatefulWidget {
  final String name, shopName, image;
  final double star;
  final int price;
  final BuildContext buildContext;

  const _ProductListWidget(
      {Key? key,
      required this.name,
      required this.image,
      required this.shopName,
      required this.star,
      required this.price,
      required this.buildContext})
      : super(key: key);

  @override
  __ProductListWidgetState createState() => __ProductListWidgetState();
}

class __ProductListWidgetState extends State<_ProductListWidget> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    String key = Generator.randomString(10);
    return InkWell(
      onTap: () {},
      child: FxContainer(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Hero(
                tag: key,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Container(
                      decoration: BoxDecoration(color: theme.backgroundColor),
                      child: Image(
                        image: AssetImage(widget.image),
                        height: 50,
                        width: 50,
                        fit: BoxFit.fitHeight,
                      ),
                    )),
              ),
            ),
            FxSpacing.width(20),
            Expanded(
              flex: 6,
              child: Container(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          MdiIcons.storeOutline,
                          color: theme.colorScheme.onBackground.withAlpha(200),
                          size: 15,
                        ),
                        FxSpacing.width(5),
                        Flexible(
                          child: FxText.bodySmall(
                            widget.shopName,
                            color:
                                theme.colorScheme.onBackground.withAlpha(200),
                            fontWeight: 500,
                            fontSize: 9,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                    Row(children: <Widget>[
                      Flexible(
                          child: Container(
                              padding: const EdgeInsets.only(right: 5),
                              child: FxText.titleSmall(
                                widget.name,
                                fontWeight: 600,
                                fontSize: 11.5,
                                letterSpacing: 0,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              )))
                    ]),
                  ])),
            ),
            Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FxButton(
                    onPressed: () {
                      Navigator.push(
                          widget.buildContext,
                          MaterialPageRoute(
                              builder: (context) => RewardDetailScreen()));
                    },
                    elevation: 1,
                    padding: EdgeInsets.all(0),
                    borderRadiusAll: 10,
                    shadowColor: Colors.grey,
                    child: FxText.bodySmall(
                      'View',
                      color: theme.colorScheme.onPrimary,
                      fontSize: 10,
                      fontWeight: 600,
                    ),
                    splashColor: theme.colorScheme.onPrimary.withAlpha(60),
                    backgroundColor: theme.primaryColor,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
