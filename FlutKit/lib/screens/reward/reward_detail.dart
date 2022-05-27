import 'package:flutkit/theme/app_notifier.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RewardDetailScreen extends StatefulWidget {
  @override
  _RewardDetailScreenState createState() => _RewardDetailScreenState();
}

class _RewardDetailScreenState extends State<RewardDetailScreen> {
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
    final subProvider = Provider.of<AppNotifier>(context);
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: theme.colorScheme.primary,
            title: FxText.sh1("Reward Detail",
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
            Container(
              child: Stack(
                children: [
                  getImage("./assets/images/apps/event/pattern-1.png"),
                ],
              ),
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
                          child: FxText.h5("jefewfwef",
                              fontSize: 22,
                              color: theme.colorScheme.onBackground,
                              fontWeight: 600),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: FxSpacing.fromLTRB(24, 16, 24, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: FxSpacing.all(8),
                              decoration: BoxDecoration(
                                  color:
                                      theme.colorScheme.primary.withAlpha(24),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Icon(
                                MdiIcons.calendar,
                                size: 18,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: FxSpacing.left(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FxText.caption("Start Date",
                                        fontWeight: 600,
                                        color: theme.colorScheme.onBackground),
                                    Container(
                                      margin: FxSpacing.top(2),
                                      child: FxText.caption("efewqfwqef",
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
                              padding: FxSpacing.all(8),
                              decoration: BoxDecoration(
                                  color:
                                      theme.colorScheme.primary.withAlpha(24),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Icon(
                                MdiIcons.calendar,
                                size: 18,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: FxSpacing.left(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FxText.caption("End Date",
                                        fontWeight: 600,
                                        color: theme.colorScheme.onBackground),
                                    Container(
                                      margin: FxSpacing.top(2),
                                      child: FxText.caption(
                                          "ewfwqefewqfwqefqwf",
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
                      ],
                    ),
                  ),
                  Container(
                    margin: FxSpacing.fromLTRB(24, 16, 24, 0),
                    child: Row(),
                  ),
                  Container(
                    margin: FxSpacing.fromLTRB(24, 24, 24, 0),
                    child: FxText.sh1("About This Event",
                        fontWeight: 700, color: theme.colorScheme.onBackground),
                  ),
                  Container(
                    margin: FxSpacing.fromLTRB(24, 12, 24, 0),
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "efewfwqefwqfweqffwq",
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
            ),
            FxButton.block(
                onPressed: () {},
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                      const Size.fromHeight(20)),
                ),
                borderRadiusAll: 0,
                backgroundColor: theme.colorScheme.primary,
                child: FxText.labelLarge(
                  "Claim",
                  color: theme.colorScheme.background,
                  fontWeight: 600,
                ))
          ],
        ));
  }

  Widget getImage(image) {
    String substring = "https";

    bool flag = image.contains(substring);

    if (flag) {
      return Image.network(
        image,
        fit: BoxFit.fill,
      );
    } else {
      return const Image(
        image: AssetImage('./assets/images/apps/event/pattern-1.png'),
        fit: BoxFit.fill,
      );
    }
  }

  Widget checkRegistrationLink(registerlink) {
    String substring = "https";

    if (registerlink.contains(substring)) {
      return Container(
        margin: FxSpacing.fromLTRB(24, 16, 24, 0),
        child: ElevatedButton(
          onPressed: () async {
            if (await canLaunch(registerlink)) {
              await launch(
                registerlink,
                forceWebView: true,
                enableJavaScript: true,
              );
            }
          },
          child: FxText.b2("Click me for more information!",
              fontWeight: 600, color: theme.colorScheme.onPrimary),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(FxSpacing.xy(16, 0))),
        ),
      );
    } else {
      final link = 'https://' + registerlink;
      return Container(
        margin: FxSpacing.fromLTRB(24, 16, 24, 0),
        child: ElevatedButton(
          onPressed: () async {
            if (await canLaunch(link)) {
              await launch(
                link,
                forceWebView: true,
                enableJavaScript: true,
              );
            }
          },
          child: FxText.b2("Click me for more information!",
              fontWeight: 600, color: theme.colorScheme.onPrimary),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(FxSpacing.xy(16, 0))),
        ),
      );
    }
  }
}
