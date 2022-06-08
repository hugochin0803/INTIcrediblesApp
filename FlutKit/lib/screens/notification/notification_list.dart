import 'package:flutkit/screens/notification/notification_detail.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/screens/event/event_ticket_screen.dart';
import 'package:flutkit/utils/generator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:provider/provider.dart';
import 'package:flutkit/theme/app_notifier.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({Key? key}) : super(key: key);

  @override
  _NotificationListScreen createState() => _NotificationListScreen();
}

class _NotificationListScreen extends State<NotificationListScreen> {
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
    final subProvider = Provider.of<AppNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: FxText.bodyLarge("Notification",
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
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: _ProductListWidget(
                  name: "Welcome to INTIcredibles",
                  shopName: "20/5/2022 12:56 P.M.",
                  star: 4.5,
                  price: 12000,
                  buildContext: context,
                )),
          ],
        )
        // body: ListView(
        //   padding: FxSpacing.zero,
        //   children: [
        //     ...List.generate(
        //         subProvider.locators.length,
        //         (int index) => Container(
        //                 child: Column(
        //               children: <Widget>[
        //                 singleEvent(
        //                     image: subProvider.locators[index]["image"],
        //                     startdate: subProvider.locators[index]["startDate"],
        //                     enddate: subProvider.locators[index]["endDate"],
        //                     name: subProvider.locators[index]["name"],
        //                     detail: subProvider.locators[index]),
        //                 Container(
        //                     margin: FxSpacing.fromLTRB(24, 0, 24, 0),
        //                     child: const Divider(
        //                       height: 0,
        //                     ))
        //               ],
        //             )))
        //   ],
        // )
        );
  }

  Widget getImage(image) {
    String substring = "https";

    bool flag = image.contains(substring);

    if (flag) {
      return Image.network(
        image,
        width: 100,
        height: 72,
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage('./assets/images/apps/event/pattern-1.png'),
        width: 100,
        height: 72,
        fit: BoxFit.cover,
      );
    }
  }
}

class _ProductListWidget extends StatefulWidget {
  final String name, shopName;
  final double star;
  final int price;
  final BuildContext buildContext;

  const _ProductListWidget(
      {Key? key,
      required this.name,
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
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotificationDetailScreen()));
      },
      child: FxContainer(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Hero(
                tag: key,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: Icon(
                        MdiIcons.bell,
                        size: 30,
                        color: theme.colorScheme.onBackground.withAlpha(160),
                      ),
                    )),
              ),
            ),
            FxSpacing.width(20),
            Expanded(
              flex: 9,
              child: Container(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(children: <Widget>[
                    Row(children: <Widget>[
                      Flexible(
                          child: Container(
                              padding: const EdgeInsets.only(right: 5),
                              child: FxText.titleSmall(
                                widget.name,
                                fontWeight: 600,
                                fontSize: 13,
                                letterSpacing: 0,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              )))
                    ]),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: FxText.bodySmall(
                            widget.shopName,
                            color:
                                theme.colorScheme.onBackground.withAlpha(200),
                            fontWeight: 500,
                            fontSize: 11,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
