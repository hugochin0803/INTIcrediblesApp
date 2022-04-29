import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';


class TwoToneIcons extends StatefulWidget {
  @override
  _TwoToneIconsState createState() => _TwoToneIconsState();
}

class _TwoToneIconsState extends State<TwoToneIcons> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(FeatherIcons.chevronLeft, size: 20,),
        ),
        title: FxText.sh1("Two Tone Icons", fontWeight: 600),
      ),
      body: ListView(
        padding: FxSpacing.vertical(16),
        children: [
          GridView.count(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              crossAxisCount: 4,
              padding: FxSpacing.all(8),
              mainAxisSpacing: 16,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 16,
              children: <Widget>[
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.panorama_fish_eye,
                  color: customTheme.violet,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.add_circle,
                  color: customTheme.violet,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.play_circle_filled,
                  color: customTheme.violet,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.account_circle,
                  color: customTheme.violet,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.check_box,
                  color: customTheme.indigo,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.add_box,
                  color: customTheme.indigo,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.slideshow,
                  color: customTheme.indigo,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.account_box,
                  color: customTheme.indigo,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.change_history,
                  color: customTheme.blue,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.warning,
                  color: customTheme.blue,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.details,
                  color: customTheme.blue,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.eject,
                  color: customTheme.blue,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.face,
                  color: customTheme.green,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.sentiment_very_satisfied,
                  color: customTheme.green,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.sentiment_neutral,
                  color: customTheme.green,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.sentiment_very_dissatisfied,
                  color: customTheme.green,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.star,
                  color: customTheme.yellow,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.star_half,
                  color: customTheme.yellow,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.stars,
                  color: customTheme.yellow,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.new_releases,
                  color: customTheme.yellow,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.home,
                  color: customTheme.orange,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.home_work,
                  color: customTheme.orange,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.deck,
                  color: customTheme.orange,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.night_shelter,
                  color: customTheme.orange,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.admin_panel_settings,
                  color: customTheme.red,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.bookmark,
                  color: customTheme.red,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.extension,
                  color: customTheme.red,
                ),
                FxTwoToneIcon(
                  FxTwoToneMdiIcons.pan_tool,
                  color: customTheme.red,
                ),
              ]),
        ],
      ),
    );
  }
}
