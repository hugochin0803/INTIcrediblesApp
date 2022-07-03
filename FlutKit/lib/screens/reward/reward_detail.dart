import 'dart:convert';

import 'package:flutkit/screens/event/event_full_app.dart';
import 'package:flutkit/theme/app_notifier.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RewardDetailScreen extends StatefulWidget {
  final int flag;
  const RewardDetailScreen({Key? key, required this.flag}) : super(key: key);

  @override
  _RewardDetailScreenState createState() => _RewardDetailScreenState(flag);
  // State<StatefulWidget> createState() {
  //   return _RewardDetailScreenState(flag);
  // }
}

class _RewardDetailScreenState extends State<RewardDetailScreen> {
  late int flag;
  _RewardDetailScreenState(this.flag);
  late CustomTheme customTheme;
  late ThemeData theme;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  void _showDialog(voucher, _scaffoldKey) {
    showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) => _TermsDialog(voucher));
  }

  int selectedCategory = 0;

  Widget build(BuildContext context) {
    final subProvider = Provider.of<AppNotifier>(context);
    return Scaffold(
        key: _scaffoldKey,
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
                  getImage(subProvider.detail['image']),
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
                              child:
                                  getLogo(subProvider.detail['merchantLogo']),
                            ),
                            Expanded(
                              child: Container(
                                margin: FxSpacing.left(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FxText.caption(
                                        subProvider.detail['merchantName'],
                                        fontWeight: 500,
                                        color: theme.colorScheme.onBackground),
                                    Container(
                                      margin: FxSpacing.top(2),
                                      child: FxText.caption(
                                        subProvider.detail['title'],
                                        fontSize: 12,
                                        fontWeight: 700,
                                        color: theme.colorScheme.onBackground,
                                      ),
                                    ),
                                    Container(
                                      margin: FxSpacing.top(2),
                                      child: FxText.caption(
                                        "Validity: " +
                                            getDate(flag, subProvider.detail),
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
                    margin: FxSpacing.fromLTRB(15, 12, 24, 20),
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: subProvider.detail['description'],
                            style: FxTextStyle.sh2(
                                color: theme.colorScheme.onBackground,
                                muted: true,
                                letterSpacing: 0.2,
                                fontSize: 12,
                                fontWeight: 500)),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            checkFlag(
                flag,
                subProvider.detail['userVoucherId'] ??
                    subProvider.detail['voucherId'])
          ],
        ));
  }

  String getDate(flag, detail) {
    if (flag == 0) {
      if (detail['expiryType'] == 2) {
        return detail['expiryDay'].toString() + " days after claim";
      } else {
        return detail['expiryDate'].toString();
      }
    } else {
      return detail['expiryDate'].toString();
    }
  }

  Widget checkFlag(flag, voucher) {
    if (flag == 0) {
      return FxButton.block(
          onPressed: () {
            _showDialog(voucher, _scaffoldKey);
          },
          child: FxText.bodyLarge(
            "Claim",
            color: theme.colorScheme.background,
            fontWeight: 600,
          ));
    } else {
      return FxButton.block(
          onPressed: () {
            _showBottomSheet(context, voucher);
          },
          child: FxText.bodyLarge(
            "Use",
            color: theme.colorScheme.background,
            fontWeight: 600,
          ));
    }
  }

  void _showBottomSheet(context, voucherId) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 16),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: FxSpacing.horizontal(15),
                            child: Center(
                                child: Image(
                              image: AssetImage('./assets/other/barcode.png'),
                              width: MediaQuery.of(context).size.width * 0.5,
                              fit: BoxFit.fill,
                            )),
                          ),
                          Container(
                            margin: FxSpacing.fromLTRB(15, 5, 15, 15),
                            child: FxText.sh1(
                                "Please show the barcode to the cashier to validate the reward",
                                textAlign: TextAlign.center,
                                fontWeight: 700,
                                color: theme.colorScheme.onBackground),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 8),
                        alignment: AlignmentDirectional.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FxButton.text(
                                borderRadiusAll: 4,
                                elevation: 2,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: FxText.bodyMedium("Use Later",
                                    fontWeight: 600,
                                    color: theme.colorScheme.primary)),
                            FxButton(
                                elevation: 2,
                                borderRadiusAll: 4,
                                onPressed: () async {
                                  useVoucher(context, voucherId);
                                },
                                child: FxText.bodyMedium("Use Now",
                                    fontWeight: 600,
                                    color: theme.colorScheme.onPrimary)),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }

  void useVoucher(context, voucher) async {
    final prefs = await SharedPreferences.getInstance();
    final userID = prefs.getInt('userID') ?? 0;
    String token = prefs.getString('token') ?? " ";

    final uri =
        Uri.http('chilamlol.pythonanywhere.com', '/voucher/redeem/$voucher');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'user-token': token
    };

    final response = await http.put(uri, headers: requestHeaders);

    if (response.statusCode == 200) {
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (context) => EventFullApp(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Server Error")));
    }
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

  Widget getLogo(image) {
    String substring = "https";

    image ??= "hehfwejhfh";

    bool flag = image.contains(substring);

    if (flag) {
      return Image.network(
        image,
        height: 40,
        width: 40,
        fit: BoxFit.fitHeight,
      );
    } else {
      return const Image(
        image: AssetImage('./assets/images/apps/event/pattern-1.png'),
        height: 40,
        width: 40,
        fit: BoxFit.fitHeight,
      );
    }
  }
}

class _TermsDialog extends StatelessWidget {
  late int voucher;
  _TermsDialog(this.voucher);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = AppTheme.theme;
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
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
                margin: const EdgeInsets.only(top: 8),
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
                        child: FxText.bodyMedium("Cancel",
                            fontWeight: 600, color: theme.colorScheme.primary)),
                    FxButton(
                        elevation: 2,
                        borderRadiusAll: 4,
                        onPressed: () {
                          claimVoucher(context, voucher);
                        },
                        child: FxText.bodyMedium("Claim",
                            fontWeight: 600,
                            color: theme.colorScheme.onPrimary)),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void claimVoucher(context, voucher) async {
    final prefs = await SharedPreferences.getInstance();
    final userID = prefs.getInt('userID') ?? 0;
    String token = prefs.getString('token') ?? " ";

    final uri = Uri.http('chilamlol.pythonanywhere.com', '/voucher/claim');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'user-token': token
    };

    final body = {"userId": userID, "voucherId": voucher};
    final jsonString = json.encode(body);
    final response =
        await http.post(uri, headers: requestHeaders, body: jsonString);

    if (response.statusCode == 200) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EventFullApp(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Server Error")));
    }
  }
}
