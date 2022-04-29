import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

class Buttons extends StatefulWidget {
  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {

  late ThemeData theme;

  @override
  void initState() {
    super.initState();
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
        title: FxText.sh1("Button", fontWeight: 600),
      ),
      body: ListView(
        padding: FxSpacing.all(24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxButton.small(
                onPressed: () {},
                child: FxText.b2(
                  'Small',
                  color: theme.colorScheme.onPrimary,
                ),
                backgroundColor: theme.primaryColor,
              ),
              FxButton.medium(
                onPressed: () {},
                child: FxText.b2(
                  'Medium',
                  color: theme.colorScheme.onPrimary,
                ),
                backgroundColor: theme.primaryColor,
              ),
              FxButton.large(
                onPressed: () {},
                child: FxText.b2(
                  'Large',
                  color: theme.colorScheme.onPrimary,
                ),
                backgroundColor: theme.primaryColor,
              ),
            ],
          ),
          FxSpacing.height(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxButton.small(
                buttonType: FxButtonType.outlined,
                borderColor: theme.primaryColor,
                onPressed: () {},
                child: FxText.b2(
                  'Small',
                  color: theme.primaryColor,
                ),
              ),
              FxButton.medium(
                buttonType: FxButtonType.outlined,
                borderColor: theme.primaryColor,
                onPressed: () {},
                child: FxText.b2(
                  'Medium',
                  color: theme.primaryColor,
                ),
              ),
              FxButton.large(
                buttonType: FxButtonType.outlined,
                borderColor: theme.primaryColor,
                onPressed: () {},
                child: FxText.b2(
                  'Large',
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          FxSpacing.height(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxButton.small(
                borderRadiusAll: 4,
                backgroundColor: theme.primaryColor,
                onPressed: () {},
                child: FxText.b2(
                  'Small',
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              FxButton.medium(
                borderRadiusAll: 4,
                backgroundColor: theme.primaryColor,
                onPressed: () {},
                child: FxText.b2(
                  'Medium',
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              FxButton.large(
                borderRadiusAll: 4,
                backgroundColor: theme.primaryColor,
                onPressed: () {},
                child: FxText.b2(
                  'Large',
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          FxSpacing.height(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxButton.small(
                onPressed: () {},
                child: FxText.b2(
                  'Small',
                  color: theme.colorScheme.primary,
                ),
                splashColor: theme.primaryColor.withAlpha(40),
                buttonType: FxButtonType.text,
              ),
              FxButton.medium(
                onPressed: () {},
                child: FxText.b2(
                  'Medium',
                  color: theme.colorScheme.primary,
                ),
                buttonType: FxButtonType.text,
                splashColor: theme.primaryColor.withAlpha(40),
              ),
              FxButton.large(
                onPressed: () {},
                child: FxText.b2(
                  'Large',
                  color: theme.colorScheme.primary,
                ),
                buttonType: FxButtonType.text,
                splashColor: theme.primaryColor.withAlpha(40),
              ),
            ],
          ),
          FxSpacing.height(24),
          FxButton.block(
            onPressed: () {},
            child: FxText.b2(
              'Block',
              color: theme.colorScheme.onPrimary,
            ),
            backgroundColor: theme.primaryColor,
          ),
        ],
      ),
    );
  }
}
