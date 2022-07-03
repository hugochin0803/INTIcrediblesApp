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
                          child: FxText("Welcome to INTIcredibles",
                              fontSize: 20,
                              color: theme.colorScheme.onBackground,
                              fontWeight: 600),
                        ),
                        FxText("22/6/2022",
                            fontSize: 12,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 600)
                      ],
                    ),
                  ),
                  Container(
                    margin: FxSpacing.fromLTRB(24, 12, 24, 0),
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Welcome Intians!",
                            style: FxTextStyle.bodySmall(
                                color: theme.colorScheme.onBackground,
                                muted: true,
                                letterSpacing: 0.3,
                                fontWeight: 500)),
                      ]),
                    ),
                  ),
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
      return const Image(
        image: AssetImage('./assets/images/all/welcome.jpg'),
        fit: BoxFit.fill,
      );
    }
  }
}
