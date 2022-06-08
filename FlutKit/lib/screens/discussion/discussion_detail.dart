import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/screens/event/event_ticket_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:provider/provider.dart';
import 'package:flutkit/theme/app_notifier.dart';

class DiscussionDetailScreen extends StatefulWidget {
  const DiscussionDetailScreen({Key? key}) : super(key: key);

  @override
  _DiscussionDetailScreen createState() => _DiscussionDetailScreen();
}

class _DiscussionDetailScreen extends State<DiscussionDetailScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: FxText.bodyLarge("Discussion Board",
                color: theme.colorScheme.onPrimary, fontWeight: 600),
            centerTitle: true,
            elevation: 4,
            backgroundColor: theme.colorScheme.primary,
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                FeatherIcons.chevronLeft,
                size: 20,
                color: theme.colorScheme.onPrimary,
              ),
            )),
        body: Column(children: [
          Expanded(
            child: ListView(
              padding: FxSpacing.top(10),
              children: [
                FxCard(
                  onTap: () {},
                  shadow: FxShadow(elevation: 4),
                  marginAll: 8,
                  paddingAll: 8,
                  borderRadiusAll: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: FxSpacing.fromLTRB(12, 8, 12, 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 13,
                                            backgroundColor:
                                                theme.colorScheme.primary,
                                            child: FxText(
                                              "J",
                                              color:
                                                  theme.colorScheme.onPrimary,
                                            ),
                                          ),
                                          FxSpacing.width(10),
                                          Expanded(
                                            flex: 1,
                                            child: FxText.titleSmall(
                                              "John Smith",
                                              fontWeight: 600,
                                            ),
                                          ),
                                          FxText.titleSmall(
                                            "20/05/2022",
                                            fontWeight: 600,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: FxSpacing.top(13),
                              child: FxText.bodyMedium(
                                  'What is Malaysians\' favorite city?\n\nSiti Nurhaliza',
                                  fontWeight: 500),
                            ),
                            Container(
                              margin: FxSpacing.top(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.favorite_outline,
                                    color: theme.colorScheme.secondary,
                                    size: 20,
                                  ),
                                  FxSpacing.width(8),
                                  FxText.bodySmall(220.toString(),
                                      fontWeight: 600),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                          margin: FxSpacing.left(16),
                                          child: Icon(
                                            Icons.share,
                                            color: theme.colorScheme.primary,
                                            size: 20,
                                          )),
                                      FxSpacing.width(8),
                                      FxText.bodySmall('Share',
                                          fontWeight: 600),
                                    ],
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
                Container(
                    margin: FxSpacing.fromLTRB(12, 5, 24, 0),
                    child: Row(
                      children: [
                        FxText(
                          "Comment",
                          fontSize: 17,
                        )
                      ],
                    )),
                FxCard(
                  onTap: () {},
                  shadow: FxShadow(elevation: 4),
                  marginAll: 8,
                  paddingAll: 4,
                  borderRadiusAll: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: FxSpacing.fromLTRB(8, 8, 12, 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 13,
                                            backgroundColor:
                                                theme.colorScheme.primary,
                                            child: FxText(
                                              "A",
                                              color:
                                                  theme.colorScheme.onPrimary,
                                            ),
                                          ),
                                          FxSpacing.width(10),
                                          Expanded(
                                            flex: 1,
                                            child: FxText.titleSmall(
                                              "Ashley Yap",
                                              fontSize: 12,
                                              fontWeight: 600,
                                            ),
                                          ),
                                          FxText.titleSmall(
                                            "20/05/2022",
                                            fontSize: 12,
                                            fontWeight: 600,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: FxSpacing.top(13),
                              child: FxText.bodyMedium(
                                'HAHA!',
                                fontWeight: 500,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                FxCard(
                  onTap: () {},
                  shadow: FxShadow(elevation: 4),
                  marginAll: 8,
                  paddingAll: 4,
                  borderRadiusAll: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: FxSpacing.fromLTRB(8, 8, 12, 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 13,
                                            backgroundColor:
                                                theme.colorScheme.primary,
                                            child: FxText(
                                              "M",
                                              color:
                                                  theme.colorScheme.onPrimary,
                                            ),
                                          ),
                                          FxSpacing.width(10),
                                          Expanded(
                                            flex: 1,
                                            child: FxText.titleSmall(
                                              "Maven Young",
                                              fontSize: 12,
                                              fontWeight: 600,
                                            ),
                                          ),
                                          FxText.titleSmall(
                                            "20/05/2022",
                                            fontSize: 12,
                                            fontWeight: 600,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: FxSpacing.top(13),
                              child: FxText.bodyMedium(
                                'Nice!',
                                fontWeight: 500,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                FxCard(
                  onTap: () {},
                  shadow: FxShadow(elevation: 4),
                  marginAll: 8,
                  paddingAll: 4,
                  borderRadiusAll: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: FxSpacing.fromLTRB(8, 8, 12, 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 13,
                                            backgroundColor:
                                                theme.colorScheme.primary,
                                            child: FxText(
                                              "C",
                                              color:
                                                  theme.colorScheme.onPrimary,
                                            ),
                                          ),
                                          FxSpacing.width(10),
                                          Expanded(
                                            flex: 1,
                                            child: FxText.titleSmall(
                                              "Choo Li Yeh",
                                              fontSize: 12,
                                              fontWeight: 600,
                                            ),
                                          ),
                                          FxText.titleSmall(
                                            "22/05/2022",
                                            fontSize: 12,
                                            fontWeight: 600,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: FxSpacing.top(13),
                              child: FxText.bodyMedium(
                                'ba dum tss!',
                                fontWeight: 500,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                FxCard(
                  onTap: () {},
                  shadow: FxShadow(elevation: 4),
                  marginAll: 8,
                  paddingAll: 4,
                  borderRadiusAll: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: FxSpacing.fromLTRB(8, 8, 12, 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 13,
                                            backgroundColor:
                                                theme.colorScheme.primary,
                                            child: FxText(
                                              "B",
                                              color:
                                                  theme.colorScheme.onPrimary,
                                            ),
                                          ),
                                          FxSpacing.width(10),
                                          Expanded(
                                            flex: 1,
                                            child: FxText.titleSmall(
                                              "Brandan Lim",
                                              fontSize: 12,
                                              fontWeight: 600,
                                            ),
                                          ),
                                          FxText.titleSmall(
                                            "23/05/2022",
                                            fontSize: 12,
                                            fontWeight: 600,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: FxSpacing.top(13),
                              child: FxText.bodyMedium(
                                'Fantastic!',
                                fontWeight: 500,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: FxSpacing.fromLTRB(10, 2, 24, 2),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(
                        color: theme.colorScheme.onBackground,
                        fontWeight: 500,
                        fontSize: 12),
                    decoration: InputDecoration(
                        fillColor: customTheme.card,
                        hintStyle: FxTextStyle.bodySmall(
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500,
                            muted: true,
                            letterSpacing: 0,
                            fontSize: 12),
                        filled: true,
                        hintText: "Comment me",
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        isDense: true,
                        contentPadding: FxSpacing.all(12)),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                Container(
                  margin: FxSpacing.left(16),
                  child: FxText.bodySmall("Post",
                      color: theme.colorScheme.primary.withAlpha(200),
                      fontWeight: 500),
                )
              ],
            ),
          ),
        ]));
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
