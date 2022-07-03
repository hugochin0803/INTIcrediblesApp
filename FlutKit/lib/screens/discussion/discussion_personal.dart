import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/screens/event/event_detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:provider/provider.dart';
import 'package:flutkit/theme/app_notifier.dart';

class DiscussionPersonalScreen extends StatefulWidget {
  const DiscussionPersonalScreen({Key? key}) : super(key: key);

  @override
  _DiscussionPersonalScreen createState() => _DiscussionPersonalScreen();
}

class _DiscussionPersonalScreen extends State<DiscussionPersonalScreen> {
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
        ),
        body: ListView(
          padding: FxSpacing.zero,
          children: [],
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
