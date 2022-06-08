import 'package:flutkit/screens/discussion/discussion_add_post.dart';
import 'package:flutkit/screens/discussion/discussion_detail.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/screens/event/event_ticket_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DiscussionAddPostScreen()),
            );
          },
          mini: true,
          child: const Icon(Icons.add),
          backgroundColor: theme.colorScheme.primary,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          title: FxText.bodyLarge("Discussion Board",
              color: theme.colorScheme.onPrimary, fontWeight: 600),
          centerTitle: true,
          elevation: 4,
          backgroundColor: theme.colorScheme.primary,
        ),
        body: ListView(
          padding: FxSpacing.bottom(20),
          children: [
            Container(
              padding: FxSpacing.fromLTRB(20, 15, 20, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.labelLarge("Let's have a look...",
                            fontWeight: 700,
                            fontSize: 20,
                            letterSpacing: 0,
                            color: theme.colorScheme.onBackground),
                        FxText.labelLarge(
                            "Share, Comment and Like your thoughts!",
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
            FxCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DiscussionDetailScreen()),
                );
              },
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 13,
                                        backgroundColor:
                                            theme.colorScheme.primary,
                                        child: FxText(
                                          "J",
                                          color: theme.colorScheme.onPrimary,
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
                              FxText.bodySmall(220.toString(), fontWeight: 600),
                              Row(
                                children: <Widget>[
                                  Container(
                                      margin: FxSpacing.left(16),
                                      child: Icon(
                                        Icons.comment,
                                        color: theme.colorScheme.primary,
                                        size: 20,
                                      )),
                                  FxSpacing.width(8),
                                  FxText.bodySmall('Comment', fontWeight: 600),
                                ],
                              ),
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
                                  FxText.bodySmall('Share', fontWeight: 600),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 13,
                                        backgroundColor:
                                            theme.colorScheme.primary,
                                        child: FxText(
                                          "B",
                                          color: theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                      FxSpacing.width(10),
                                      Expanded(
                                        flex: 1,
                                        child: FxText.titleSmall(
                                          "Brandan Walker",
                                          fontWeight: 600,
                                        ),
                                      ),
                                      FxText.titleSmall(
                                        "05/01/2022",
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
                              'Hiring 5 fresh graduates from INTI to be placed in Maybank Kuala Lumpur, Jalan Tun Perak under the IT Department (Networking)',
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
                              FxText.bodySmall(220.toString(), fontWeight: 600),
                              Row(
                                children: <Widget>[
                                  Container(
                                      margin: FxSpacing.left(16),
                                      child: Icon(
                                        Icons.comment,
                                        color: theme.colorScheme.primary,
                                        size: 20,
                                      )),
                                  FxSpacing.width(8),
                                  FxText.bodySmall('Comment', fontWeight: 600),
                                ],
                              ),
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
                                  FxText.bodySmall('Share', fontWeight: 600),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 13,
                                        backgroundColor:
                                            theme.colorScheme.primary,
                                        child: FxText(
                                          "J",
                                          color: theme.colorScheme.onPrimary,
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
                                        "25/06/2020",
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
                              'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.',
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
                              FxText.bodySmall(220.toString(), fontWeight: 600),
                              Row(
                                children: <Widget>[
                                  Container(
                                      margin: FxSpacing.left(16),
                                      child: Icon(
                                        Icons.comment,
                                        color: theme.colorScheme.primary,
                                        size: 20,
                                      )),
                                  FxSpacing.width(8),
                                  FxText.bodySmall('Comment', fontWeight: 600),
                                ],
                              ),
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
                                  FxText.bodySmall('Share', fontWeight: 600),
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
          ],
        ));
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
