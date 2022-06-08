import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/screens/event/event_ticket_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import 'package:provider/provider.dart';
import 'package:flutkit/theme/app_notifier.dart';

class EventUpcomingScreen extends StatefulWidget {
  @override
  _EventUpcomingScreenState createState() => _EventUpcomingScreenState();
}

class _EventUpcomingScreenState extends State<EventUpcomingScreen> {
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
          elevation: 4,
          centerTitle: true,
          backgroundColor: theme.colorScheme.primary,
          automaticallyImplyLeading: false,
          title: FxText.sh1("Upcoming Event",
              color: theme.colorScheme.onPrimary, fontWeight: 600),
        ),
        body: ListView(
          padding: FxSpacing.zero,
          children: [
            Container(
              padding: FxSpacing.fromLTRB(24, 20, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.labelLarge("They are happening!",
                            fontWeight: 700,
                            fontSize: 20,
                            letterSpacing: 0,
                            color: theme.colorScheme.onBackground),
                        FxText.labelLarge("Join our exclusive event now!",
                            fontWeight: 300,
                            fontSize: 12,
                            letterSpacing: 0,
                            color: theme.colorScheme.onBackground),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: FxSpacing.fromLTRB(24, 20, 24, 0),
                child: const Divider(
                  height: 0,
                )),
            ...List.generate(
                subProvider.locators.length,
                (int index) => Container(
                        child: Column(
                      children: <Widget>[
                        singleEvent(
                            image: subProvider.locators[index]["image"],
                            startdate: subProvider.locators[index]["startDate"],
                            enddate: subProvider.locators[index]["endDate"],
                            name: subProvider.locators[index]["name"],
                            detail: subProvider.locators[index]),
                        Container(
                            margin: FxSpacing.fromLTRB(24, 0, 24, 0),
                            child: const Divider(
                              height: 0,
                            ))
                      ],
                    )))
          ],
        ));
  }

  Widget singleEvent(
      {required String image,
      required String name,
      required String startdate,
      required String enddate,
      dynamic detail}) {
    final subProvider = Provider.of<AppNotifier>(context);
    return Container(
      margin: FxSpacing.fromLTRB(24, 15, 24, 15),
      child: InkWell(
        onTap: () {
          subProvider.detail = detail;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EventTicketScreen()));
        },
        child: Row(
          children: [
            ClipRect(
              clipBehavior: Clip.hardEdge,
              child: getImage(image),
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
        fit: BoxFit.scaleDown,
      );
    } else {
      return const Image(
        image: AssetImage('./assets/images/apps/event/pattern-1.png'),
        width: 100,
        height: 72,
        fit: BoxFit.scaleDown,
      );
    }
  }
}
