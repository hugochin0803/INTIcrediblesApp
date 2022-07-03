import 'package:flutkit/screens/reward/reward_detail.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/screens/event/event_detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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
    subProvider.callRewardAPI();
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
    final subProvider = Provider.of<AppNotifier>(context);
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: RefreshIndicator(
            backgroundColor: theme.backgroundColor,
            onRefresh: () async {
              setState(() {
                subProvider.callRewardAPI();
              });
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              children: <Widget>[
                ...List.generate(
                    subProvider.voucher.length,
                    (int index) => Column(
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: _ProductListWidget(
                                    name: subProvider.voucher[index]["title"],
                                    image: subProvider.voucher[index]
                                        ["merchantLogo"],
                                    shopName: subProvider.voucher[index]
                                        ["merchantName"],
                                    buildContext: context,
                                    flag: 0,
                                    detail: subProvider.voucher[index])),
                          ],
                        ))
              ],
            ))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget getTabContent2(BuildContext context) {
    final subProvider = Provider.of<AppNotifier>(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: RefreshIndicator(
          backgroundColor: theme.backgroundColor,
          onRefresh: () async {
            setState(() {
              subProvider.callRewardAPI();
            });
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            children: <Widget>[
              ...List.generate(
                  subProvider.voucherUser.length,
                  (int index) => Column(
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: _ProductListWidget(
                                  name: subProvider.voucherUser[index]["title"],
                                  image: subProvider.voucherUser[index]
                                      ["merchantLogo"],
                                  shopName: subProvider.voucherUser[index]
                                      ["merchantName"],
                                  buildContext: context,
                                  flag: 1,
                                  detail: subProvider.voucherUser[index])),
                        ],
                      ))
            ],
          )),
    );
  }

  Future<Null> _refreshLocalGallery() async {
    print('refreshing stocks...');
  }
}

class _ProductListWidget extends StatefulWidget {
  final String name, shopName, image;
  final int flag;
  final BuildContext buildContext;
  final dynamic detail;

  const _ProductListWidget({
    Key? key,
    required this.name,
    required this.image,
    required this.shopName,
    required this.buildContext,
    required this.flag,
    required this.detail,
  }) : super(key: key);

  @override
  __ProductListWidgetState createState() => __ProductListWidgetState();
}

class __ProductListWidgetState extends State<_ProductListWidget> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    String key = Generator.randomString(10);
    final subProvider = Provider.of<AppNotifier>(context);
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
                      child: getImage(widget.image),
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
                      subProvider.detail = widget.detail;
                      Navigator.push(
                          widget.buildContext,
                          MaterialPageRoute(
                              builder: (context) => RewardDetailScreen(
                                    flag: widget.flag,
                                  )));
                    },
                    elevation: 1,
                    padding: const EdgeInsets.all(0),
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

  Widget getImage(image) {
    String substring = "https";

    bool flag = image.contains(substring);

    if (flag) {
      return Image.network(
        image,
        height: 50,
        width: 50,
        fit: BoxFit.fitHeight,
      );
    } else {
      return const Image(
        image: AssetImage('./assets/images/apps/event/pattern-1.png'),
        height: 50,
        width: 50,
        fit: BoxFit.fitHeight,
      );
    }
  }
}
