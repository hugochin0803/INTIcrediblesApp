import 'package:flutkit/theme/app_notifier.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationDetailScreen extends StatefulWidget {
  @override
  _NotificationDetailScreen createState() => _NotificationDetailScreen();
}

class _NotificationDetailScreen extends State<NotificationDetailScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  int selectedCategory = 0;

  Widget build(BuildContext context) {
    //final subProvider = Provider.of<AppNotifier>(context);
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: theme.colorScheme.primary,
            title: FxText.sh1("Notification",
                color: theme.colorScheme.onPrimary, fontWeight: 600),
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                FeatherIcons.chevronLeft,
                size: 20,
                color: theme.colorScheme.onPrimary,
              ),
            )),
        body: Column(
          children: [
            Stack(
              children: [
                getImage(""),
              ],
            ),
            Expanded(
              child: ListView(
                padding: FxSpacing.vertical(16),
                children: [
                  Container(
                    margin: FxSpacing.fromLTRB(24, 0, 24, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: FxText.h5("Welcome to INTIcredibles",
                              fontSize: 20,
                              color: theme.colorScheme.onBackground,
                              fontWeight: 600),
                        ),
                        Container(
                            child: FxText(
                          "19/2/2020",
                          fontSize: 12,
                        ))
                      ],
                    ),
                  ),

                  Container(
                    margin: FxSpacing.fromLTRB(24, 12, 24, 0),
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Welcome Intians!",
                            style: FxTextStyle.sh2(
                                color: theme.colorScheme.onBackground,
                                muted: true,
                                letterSpacing: 0.3,
                                fontWeight: 500)),
                      ]),
                    ),
                  ),
                  //checkRegistrationLink(subProvider.detail['registerLink']),
                ],
              ),
            )
          ],
        ));
  }

  Widget getImage(image) {
    String substring = "https";

    bool flag = image.contains(substring);

    if (flag) {
      return Image.network(image, fit: BoxFit.fill);
    } else {
      return Image(
        image: AssetImage('./assets/images/apps/event/pattern-1.png'),
        fit: BoxFit.fill,
      );
    }
  }

  // Widget checkRegistrationLink(registerlink) {
  //   String substring = "https";

  //   if (registerlink.contains(substring)) {
  //     return Container(
  //       margin: FxSpacing.fromLTRB(24, 16, 24, 0),
  //       child: ElevatedButton(
  //         onPressed: () async {
  //           if (await canLaunch(registerlink)) {
  //             await launch(
  //               registerlink,
  //               forceWebView: true,
  //               enableJavaScript: true,
  //             );
  //           }
  //         },
  //         child: FxText.b2("Click me for more information!",
  //             fontWeight: 600, color: theme.colorScheme.onPrimary),
  //         style: ButtonStyle(
  //             padding: MaterialStateProperty.all(FxSpacing.xy(16, 0))),
  //       ),
  //     );
  //   } else {
  //     final link = 'https://' + registerlink;
  //     return Container(
  //       margin: FxSpacing.fromLTRB(24, 16, 24, 0),
  //       child: ElevatedButton(
  //         onPressed: () async {
  //           final url = Uri(scheme: 'https', host: registerlink);
  //           if (await canLaunchUrl(url)) {
  //             await launchUrl(url, mode: LaunchMode.externalApplication);
  //           }
  //         },
  //         child: FxText.b2("Click me for more information!",
  //             fontWeight: 600, color: theme.colorScheme.onPrimary),
  //         style: ButtonStyle(
  //             padding: MaterialStateProperty.all(FxSpacing.xy(16, 0))),
  //       ),
  //     );
  //   }
  // }
}
