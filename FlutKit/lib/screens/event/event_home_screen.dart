import 'dart:developer';

import 'package:flutkit/screens/event/event_profile_screen.dart';
import 'package:flutkit/screens/event/event_detail_screen.dart';
import 'package:flutkit/screens/notification/notification_list.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';
import 'package:flutkit/theme/app_notifier.dart';

class EventHomeScreen extends StatefulWidget {
  const EventHomeScreen({Key? key}) : super(key: key);

  @override
  _EventHomeScreenState createState() => _EventHomeScreenState();
}

class _EventHomeScreenState extends State<EventHomeScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  String date = "", name = "";

  @override
  void initState() {
    super.initState();
    final subProvider = Provider.of<AppNotifier>(context, listen: false);
    subProvider.callEventHomeAPI();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    date = formattedDate;
    loadname();
  }

  loadname() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? " ";
  }

  int? selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    final subProvider = Provider.of<AppNotifier>(context);
    return Scaffold(
        appBar: AppBar(
            elevation: 4,
            backgroundColor: const Color(0xFFEC3E37),
            automaticallyImplyLeading: false,
            shadowColor: Colors.grey,
            title: Container(
                padding: FxSpacing.fromLTRB(10, 0, 0, 0),
                child: Row(children: <Widget>[
                  FxText.bodyLarge(
                    "INTIcredibles",
                    color: theme.colorScheme.onPrimary,
                    fontWeight: 600,
                    fontSize: 18,
                  ),
                ]))),
        body: ListView(
          children: [
            Container(
              margin: FxSpacing.fromLTRB(24, 20, 24, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.bodyMedium("Welcome,",
                            fontWeight: 500,
                            letterSpacing: 0,
                            color: theme.colorScheme.onBackground),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: FxText.headlineSmall(name,
                              fontSize: 26,
                              fontWeight: 700,
                              letterSpacing: -0.3,
                              color: theme.colorScheme.onBackground),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationListScreen()),
                        );
                      },
                      child: Stack(
                        children: [
                          FxContainer(
                            padding: FxSpacing.all(10),
                            borderRadiusAll: 4,
                            child: Icon(
                              MdiIcons.bell,
                              size: 18,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(160),
                            ),
                          ),
                          Positioned(
                            right: 4,
                            top: 4,
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                  color: customTheme.colorError,
                                  shape: BoxShape.circle),
                            ),
                          )
                        ],
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventProfileScreen()),
                        );
                      },
                      child: FxContainer(
                        padding: FxSpacing.all(8),
                        margin: FxSpacing.left(16),
                        borderRadiusAll: 4,
                        child: Icon(
                          MdiIcons.accountCircle,
                          size: 23,
                          color: theme.colorScheme.onBackground.withAlpha(160),
                        ),
                      ))
                ],
              ),
            ),
            Container(
              margin: FxSpacing.fromLTRB(24, 0, 24, 0),
              child: FxText.headlineMedium("Discover Events",
                  fontSize: 24,
                  fontWeight: 700,
                  letterSpacing: -0.3,
                  color: theme.colorScheme.onBackground),
            ),
            Container(
              margin: FxSpacing.fromLTRB(24, 4, 24, 20),
              child: Row(
                children: [
                  Expanded(
                    child: FxText.titleLarge("Highlight",
                        fontSize: 17,
                        fontWeight: 700,
                        color: theme.colorScheme.onBackground),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: FxSpacing.zero,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                        subProvider.locators1.length,
                        (int index) => Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              margin: FxSpacing.left(24),
                              child: singleEvent(
                                  title: subProvider.locators1[index]["name"],
                                  image: subProvider.locators1[index]["image"],
                                  date: DateFormat.d().format(DateTime.parse(
                                      subProvider.locators1[index]
                                          ["startDate"])),
                                  month: DateFormat.MMM().format(DateTime.parse(
                                      subProvider.locators1[index]
                                          ["startDate"])),
                                  startDate: "Start at: " +
                                      DateFormat.yMMMd().add_jm().format(
                                          DateTime.parse(subProvider.locators1[index]["startDate"])),
                                  endDate: "End at: " + DateFormat.yMMMd().add_jm().format(DateTime.parse(subProvider.locators1[index]["endDate"])),
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  detail: subProvider.locators1[index]),
                            )),
                    Container(
                      margin: FxSpacing.fromLTRB(16, 0, 20, 0),
                    ),
                  ],
                )),
            Container(
              margin: FxSpacing.fromLTRB(24, 16, 24, 0),
              child: FxText.titleLarge("This Week",
                  fontSize: 17,
                  fontWeight: 700,
                  color: theme.colorScheme.onBackground),
            ),
            ...List.generate(
                subProvider.locators2.length,
                (int index2) => Container(
                      margin: FxSpacing.fromLTRB(24, 16, 24, 16),
                      child: singleEvent(
                          title: subProvider.locators2[index2]["name"],
                          image: subProvider.locators2[index2]["image"],
                          date: DateFormat.d().format(DateTime.parse(
                              subProvider.locators2[index2]["startDate"])),
                          month: DateFormat.MMM().format(DateTime.parse(
                              subProvider.locators2[index2]["startDate"])),
                          startDate: "Start at: " +
                              DateFormat.yMMMd().add_jm().format(DateTime.parse(
                                  subProvider.locators2[index2]["startDate"])),
                          endDate: "End at: " +
                              DateFormat.yMMMd().add_jm().format(
                                  DateTime.parse(subProvider.locators2[index2]["endDate"])),
                          width: MediaQuery.of(context).size.width - 48,
                          detail: subProvider.locators2[index2]),
                    )),
          ],
        ));
  }

  Widget singleCategory(
      {IconData? iconData, required String title, int? index}) {
    bool isSelected = (selectedCategory == index);
    return InkWell(
        onTap: () {
          if (!isSelected) {
            setState(() {
              selectedCategory = index;
            });
          }
        },
        child: FxContainer(
          margin: FxSpacing.fromLTRB(12, 8, 0, 8),
          color: isSelected ? theme.colorScheme.primary : customTheme.card,
          bordered: !isSelected,
          border: Border.all(color: customTheme.border),
          borderRadiusAll: 4,
          padding: FxSpacing.fromLTRB(16, 8, 16, 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                size: 22,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onBackground,
              ),
              Container(
                margin: FxSpacing.left(8),
                child: FxText.bodyMedium(title,
                    color: isSelected
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onBackground),
              )
            ],
          ),
        ));
  }

  Widget singleEvent(
      {required String image,
      required String date,
      required String month,
      required String title,
      required String startDate,
      required String endDate,
      required double width,
      dynamic detail}) {
    final subProvider = Provider.of<AppNotifier>(context);
    return InkWell(
      onTap: () {
        subProvider.detail = detail;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EventTicketScreen()));
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: customTheme.card,
            border: Border.all(color: customTheme.border, width: 0.8),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(2),
                      topRight: Radius.circular(2)),
                  child: getImage(image, width),
                ),
                Positioned(
                  bottom: -16,
                  left: 16,
                  child: FxContainer.bordered(
                    padding: FxSpacing.fromLTRB(8, 4, 8, 4),
                    borderRadiusAll: 4,
                    child: Column(
                      children: [
                        FxText.bodyMedium(
                          date,
                          color: theme.colorScheme.primary,
                          fontWeight: 600,
                          textAlign: TextAlign.center,
                        ),
                        FxText.bodyMedium(
                          month,
                          fontSize: 11,
                          color: theme.colorScheme.primary,
                          fontWeight: 600,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: FxSpacing.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.titleSmall(
                    title,
                    color: theme.colorScheme.onBackground,
                    fontWeight: 600,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  Container(
                    margin: FxSpacing.top(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  startDate,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      color: theme.colorScheme.onBackground),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.cover,
                                child: Text(endDate,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                        color: theme.colorScheme.onBackground)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getImage(image, width) {
    String substring = "https";

    bool flag = image.contains(substring);

    if (flag) {
      return Image.network(
        image,
        fit: BoxFit.cover,
        width: width,
        height: width * 0.55,
      );
    } else {
      return Image(
        image: const AssetImage('./assets/images/apps/event/pattern-1.png'),
        fit: BoxFit.cover,
        width: width,
        height: width * 0.55,
      );
    }
  }
}
