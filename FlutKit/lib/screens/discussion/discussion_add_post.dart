import 'package:flutkit/screens/discussion/discussion_list.dart';
import 'package:flutkit/screens/event/event_full_app.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/screens/event/event_ticket_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:provider/provider.dart';

class DiscussionAddPostScreen extends StatefulWidget {
  const DiscussionAddPostScreen({Key? key}) : super(key: key);

  @override
  _DiscussionAddPostScreen createState() => _DiscussionAddPostScreen();
}

class _DiscussionAddPostScreen extends State<DiscussionAddPostScreen> {
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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: FxText.bodyLarge("Add Post",
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
        body: ListView(
          padding: FxSpacing.zero,
          children: [
            Container(
              margin: FxSpacing.fromLTRB(5, 10, 5, 10),
              child: Column(children: [
                Container(
                    padding: FxSpacing.fromLTRB(15, 20, 15, 5),
                    child: Row(
                      children: [
                        FxText(
                          "Anything to share?",
                          fontWeight: 600,
                          fontSize: 19,
                        )
                      ],
                    )),
                Container(
                    padding: FxSpacing.fromLTRB(15, 10, 15, 5),
                    child: Row(
                      children: [
                        FxText(
                          "Content:",
                          fontWeight: 500,
                          fontSize: 18,
                        )
                      ],
                    )),
                Container(
                  padding: FxSpacing.fromLTRB(15, 5, 15, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Tell me your thought!",
                      isDense: true,
                      filled: true,
                      fillColor: theme.colorScheme.background,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 10,
                    maxLines: 20,
                  ),
                ),
                Container(
                  padding: FxSpacing.fromLTRB(15, 10, 15, 10),
                  child: FxText(
                    "* After submitting the post, this post will be pending for admin to approve. All post must be approved by the admin before displaying in the discussion board.",
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
                Container(
                    padding: FxSpacing.fromLTRB(15, 10, 15, 10),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: FxButton(
                          onPressed: () {
                            _showDialog();
                          },
                          elevation: 1,
                          padding: EdgeInsets.all(0),
                          borderRadiusAll: 10,
                          shadowColor: Colors.grey,
                          child: FxText.bodySmall(
                            'Submit',
                            color: theme.colorScheme.onPrimary,
                            fontSize: 12,
                            fontWeight: 600,
                          ),
                          splashColor:
                              theme.colorScheme.onPrimary.withAlpha(60),
                          backgroundColor: theme.primaryColor,
                        )))
              ]),
            )
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

class _TermsDialog extends StatelessWidget {
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
                        text: "Are you sure you want to post this?",
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
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => EventFullApp()),
                              (Route<dynamic> route) => false);
                        },
                        child: FxText.bodyMedium("Cancel",
                            fontWeight: 600, color: theme.colorScheme.primary)),
                    FxButton(
                        elevation: 2,
                        borderRadiusAll: 4,
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => EventFullApp()),
                              (Route<dynamic> route) => false);
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
