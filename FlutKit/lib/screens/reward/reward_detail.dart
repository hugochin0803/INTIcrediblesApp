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

  void _showDialog() {
    showDialog(
        context: context, builder: (BuildContext context) => _TermsDialog());
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
            Expanded(
              child: ListView(
                children: [
                  const Image(
                    image: AssetImage('./assets/images/all/frap.jpg'),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: FxSpacing.fromLTRB(15, 15, 24, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: FxSpacing.all(4),
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.onPrimary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: const Image(
                                image: AssetImage(
                                    './assets/images/all/starbucks.png'),
                                height: 40,
                                width: 40,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: FxSpacing.left(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FxText.caption("Starbucks",
                                        fontWeight: 500,
                                        color: theme.colorScheme.onBackground),
                                    Container(
                                      margin: FxSpacing.top(2),
                                      child: FxText.caption(
                                        "Get FREE Frappuccino Blended Beverage",
                                        fontSize: 12,
                                        fontWeight: 700,
                                        color: theme.colorScheme.onBackground,
                                      ),
                                    ),
                                    Container(
                                      margin: FxSpacing.top(2),
                                      child: FxText.caption(
                                        "Validity: 365 days after claim",
                                        fontSize: 8,
                                        fontWeight: 700,
                                        color: theme.colorScheme.primary,
                                      ),
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
                    margin: FxSpacing.fromLTRB(15, 12, 24, 0),
                    child: FxText.sh1("Description",
                        fontWeight: 700, color: theme.colorScheme.onBackground),
                  ),
                  Container(
                    margin: FxSpacing.fromLTRB(15, 12, 24, 0),
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text:
                                "ABOUT THE PRODUCT \n\n1)You will receieve 1 voucher for 1 FREE Frappuccino Blended Beverage (Mocha/Expresso/Caramel).\n\n2)Valid for TALL size(12oz) Frappuccino Blended Beverage (Mocha/Expresso/Caramel) only.",
                            style: FxTextStyle.sh2(
                                color: theme.colorScheme.onBackground,
                                muted: true,
                                letterSpacing: 0.2,
                                fontSize: 12,
                                fontWeight: 500)),
                      ]),
                    ),
                  ),
                  //checkRegistrationLink(subProvider.detail['registerLink']),
                ],
              ),
            ),
            FxButton.block(
                onPressed: () {
                  _showDialog();
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(FxSpacing.xy(0, 0))),
                child: FxText.labelSmall(
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

class _TermsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = AppTheme.theme;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: new BoxDecoration(
          color: theme.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: FxText.titleLarge("Confirm?", fontWeight: 800),
                  ),
                ),
              ],
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: RichText(
                text: TextSpan(
                    style: FxTextStyle.titleSmall(
                        fontWeight: 600, letterSpacing: 0.2),
                    children: const <TextSpan>[
                      TextSpan(
                        text: "Are you sure you want to claim?",
                      ),
                    ]),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 8),
                alignment: AlignmentDirectional.centerEnd,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FxButton.text(
                        borderRadiusAll: 4,
                        elevation: 2,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: FxText.bodyMedium("Decline",
                            fontWeight: 600, color: theme.colorScheme.primary)),
                    FxButton(
                        elevation: 2,
                        borderRadiusAll: 4,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: FxText.bodyMedium("Accept",
                            fontWeight: 600,
                            color: theme.colorScheme.onPrimary)),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
