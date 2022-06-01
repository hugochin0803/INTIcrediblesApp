import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/screens/event/event_ticket_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import 'package:provider/provider.dart';
import 'package:flutkit/theme/app_notifier.dart';

class DiscussionListScreen extends StatefulWidget {
  const DiscussionListScreen({Key? key}) : super(key: key);

  @override
  _DiscussionListScreen createState() => _DiscussionListScreen();
}

class _DiscussionListScreen extends State<DiscussionListScreen> {
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
          title: FxText.bodyLarge("Discussion board",
              color: theme.colorScheme.onPrimary, fontWeight: 600),
          centerTitle: true,
          elevation: 0,
          backgroundColor: theme.colorScheme.primary,
        ),
        body: Center(child: Text("Under Development"))
        //     body: ListView(
        //       padding: FxSpacing.zero,
        //       children: [
        //         ...List.generate(
        //             subProvider.locators.length,
        //             (int index) => Container(
        //                     child: Column(
        //                   children: <Widget>[
        //                     singleEvent(
        //                         image: subProvider.locators[index]["image"],
        //                         startdate: subProvider.locators[index]["startDate"],
        //                         enddate: subProvider.locators[index]["endDate"],
        //                         name: subProvider.locators[index]["name"],
        //                         detail: subProvider.locators[index]),
        //                     Container(
        //                         margin: FxSpacing.fromLTRB(24, 0, 24, 0),
        //                         child: const Divider(
        //                           height: 0,
        //                         ))
        //                   ],
        //                 )))
        //       ],
        //     )
        );
  }

  Widget singleEvent(
      {required String image,
      required String name,
      required String startdate,
      required String enddate,
      dynamic detail}) {
    final subProvider = Provider.of<AppNotifier>(context);
    return Container(
      margin: FxSpacing.all(24),
      child: InkWell(
        onTap: () {
          subProvider.detail = detail;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EventTicketScreen()));
        },
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: getImage(image),
              ),
            ),
            Expanded(
              child: Container(
                margin: FxSpacing.left(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.sh2(
                      name,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 600,
                      fontSize: 12,
                    ),
                    Container(
                      margin: FxSpacing.top(8),
                      child: Row(
                        children: [
                          Container(
                            padding: FxSpacing.all(0),
                          ),
                          Expanded(
                            child: Container(
                              margin: FxSpacing.left(0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FxText.caption("Start Date",
                                      fontWeight: 600,
                                      color: theme.colorScheme.onBackground),
                                  Container(
                                    margin: FxSpacing.top(2),
                                    child: FxText.caption(startdate,
                                        fontSize: 12,
                                        fontWeight: 500,
                                        color: theme.colorScheme.onBackground,
                                        xMuted: true),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: FxSpacing.all(0),
                          ),
                          Expanded(
                            child: Container(
                              margin: FxSpacing.left(0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FxText.caption("End Date",
                                      fontWeight: 600,
                                      color: theme.colorScheme.onBackground),
                                  Container(
                                    margin: FxSpacing.top(2),
                                    child: FxText.caption(enddate,
                                        fontSize: 12,
                                        fontWeight: 500,
                                        color: theme.colorScheme.onBackground,
                                        xMuted: true),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   padding: FxSpacing.fromLTRB(16, 4, 4, 4),
                          //   decoration: BoxDecoration(
                          //       color: theme.colorScheme.primary.withAlpha(28),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(32))),
                          //   child: Row(
                          //     children: [
                          //       FxText.caption("Add to Reminder",
                          //           letterSpacing: 0,
                          //           fontSize: 12,
                          //           color: theme.colorScheme.primary,
                          //           fontWeight: 400),
                          //       Container(
                          //         padding: FxSpacing.all(8),
                          //         margin: FxSpacing.left(8),
                          //         decoration: BoxDecoration(
                          //             color: theme.colorScheme.primary,
                          //             shape: BoxShape.circle),
                          //         child: Icon(
                          //           MdiIcons.plus,
                          //           color: theme.colorScheme.onPrimary,
                          //           size: 18,
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
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
