import 'dart:convert';

import 'package:flutkit/screens/discussion/discussion_add_post.dart';
import 'package:flutkit/screens/discussion/discussion_detail.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/screens/event/event_detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:provider/provider.dart';
import 'package:flutkit/theme/app_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../event/event_full_app.dart';

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
    final subProvider = Provider.of<AppNotifier>(context, listen: false);
    subProvider.callPostAPI();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    final subProvider = Provider.of<AppNotifier>(context);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DiscussionAddPostScreen()),
            );
          },
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
                            "Comment, Like and Share your thoughts!",
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
            ...List.generate(
                subProvider.post.length,
                (int index) => Column(children: <Widget>[
                      singleEvent(
                          userimage:
                              checkNull(subProvider.post[index]['userProfile']),
                          username: subProvider.post[index]['userName'],
                          text: subProvider.post[index]['text'],
                          createdDate: dateFormat(
                              subProvider.post[index]['createdDate']),
                          likecount: subProvider.post[index]['likeCount'],
                          userLike: subProvider.post[index]['userLike'],
                          postId: subProvider.post[index]['postId'],
                          detail: subProvider.post[index],
                          index: index)
                    ])),
            // FxCard(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const DiscussionDetailScreen()),
            //     );
            //   },
            //   shadow: FxShadow(elevation: 4),
            //   marginAll: 8,
            //   paddingAll: 8,
            //   borderRadiusAll: 10,
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Container(
            //         padding: FxSpacing.fromLTRB(12, 8, 12, 8),
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: <Widget>[
            //                 Expanded(
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: <Widget>[
            //                       Row(
            //                         children: <Widget>[
            //                           CircleAvatar(
            //                             radius: 13,
            //                             backgroundColor:
            //                                 theme.colorScheme.primary,
            //                             child: FxText(
            //                               "J",
            //                               color: theme.colorScheme.onPrimary,
            //                             ),
            //                           ),
            //                           FxSpacing.width(10),
            //                           Expanded(
            //                             flex: 1,
            //                             child: FxText.titleSmall(
            //                               "John Smith",
            //                               fontWeight: 600,
            //                             ),
            //                           ),
            //                           FxText.titleSmall(
            //                             "20/05/2022",
            //                             fontWeight: 600,
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 )
            //               ],
            //             ),
            //             Container(
            //               margin: FxSpacing.top(13),
            //               child: FxText.bodyMedium(
            //                   'Hiring 5 fresh graduates from INTI to be placed in Maybank Kuala Lumpur, Jalan Tun Perak under the IT Department (Networking)',
            //                   fontWeight: 500),
            //             ),
            //             Container(
            //               margin: FxSpacing.top(16),
            //               child: Row(
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: <Widget>[
            //                   GestureDetector(
            //                       onTap: () {
            //                         setState(() {
            //                           _like = !_like!;

            //                           if (_like == false) {
            //                             count = count - 1;
            //                           } else {
            //                             count = count + 1;
            //                           }
            //                         });
            //                       },
            //                       child: Icon(
            //                         _like!
            //                             ? Icons.favorite
            //                             : Icons.favorite_outline,
            //                         color: theme.colorScheme.secondary,
            //                         size: 20,
            //                       )),
            //                   FxSpacing.width(8),
            //                   FxText.bodySmall(count.toString(),
            //                       fontWeight: 600),
            //                   Row(
            //                     children: <Widget>[
            //                       Container(
            //                           margin: FxSpacing.left(16),
            //                           child: Icon(
            //                             Icons.comment,
            //                             color: theme.colorScheme.primary,
            //                             size: 20,
            //                           )),
            //                       FxSpacing.width(8),
            //                       FxText.bodySmall('Comment', fontWeight: 600),
            //                     ],
            //                   ),
            //                   GestureDetector(
            //                     onTap: () {
            //                       final box =
            //                           context.findRenderObject() as RenderBox?;
            //                       Share.shareWithResult(
            //                           "http://inticredibles.com/?share=123456",
            //                           subject: "Hi",
            //                           sharePositionOrigin:
            //                               box!.localToGlobal(Offset.zero) &
            //                                   box.size);
            //                     },
            //                     child: Row(
            //                       children: <Widget>[
            //                         Container(
            //                             margin: FxSpacing.left(16),
            //                             child: Icon(
            //                               Icons.share,
            //                               color: theme.colorScheme.primary,
            //                               size: 20,
            //                             )),
            //                         FxSpacing.width(8),
            //                         FxText.bodySmall('Share', fontWeight: 600),
            //                       ],
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             )
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ));
  }

  String checkNull(image) {
    if (image == null) {
      return "emptyImage";
    } else {
      return image;
    }
  }

  String dateFormat(date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy').add_jm();
    date = DateTime.parse(date);
    final String formatted = formatter.format(date);
    return formatted;
  }

  Widget singleEvent({
    required String userimage,
    required String username,
    required String text,
    required String createdDate,
    required int likecount,
    required bool userLike,
    required int postId,
    dynamic detail,
    required int index,
  }) {
    final subProvider = Provider.of<AppNotifier>(context);
    return FxCard(
      onTap: () {
        subProvider.detail = detail;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DiscussionDetailScreen(
                    index: index,
                  )),
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
                                  backgroundColor: theme.colorScheme.primary,
                                  child: getImage(userimage)),
                              FxSpacing.width(10),
                              Expanded(
                                flex: 1,
                                child: FxText.titleSmall(
                                  username,
                                  fontWeight: 600,
                                ),
                              ),
                              FxText.titleSmall(
                                createdDate,
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
                  child: FxText.bodyMedium(text, fontWeight: 500),
                ),
                Container(
                  margin: FxSpacing.top(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            if (!userLike) {
                              likeProfile(postId, context);
                            } else {
                              unlikeProfile(postId, context);
                            }
                          },
                          child: Icon(
                            userLike ? Icons.favorite : Icons.favorite_outline,
                            color: theme.colorScheme.secondary,
                            size: 20,
                          )),
                      FxSpacing.width(8),
                      FxText.bodySmall(likecount.toString(), fontWeight: 600),
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
                      GestureDetector(
                        onTap: () {
                          final box = context.findRenderObject() as RenderBox?;
                          Share.shareWithResult(
                              "http://inticredibles.com/?share=123456",
                              subject: "Hi",
                              sharePositionOrigin:
                                  box!.localToGlobal(Offset.zero) & box.size);
                        },
                        child: Row(
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
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> likeProfile(postId, context) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? " ";
    final userID = prefs.getInt('userID') ?? 0;

    final body = {"userId": userID, "postId": postId};
    final jsonString = json.encode(body);
    final uri = Uri.http('chilamlol.pythonanywhere.com', '/like/add');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'user-token': token
    };
    final response = await http.post(uri, headers: headers, body: jsonString);

    if (response.statusCode == 201) {
      setState(() {
        Future.delayed(Duration(milliseconds: 100));
        Provider.of<AppNotifier>(context, listen: false).callPostAPI();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "There is an issue on our end! Please contact admin for assistance!")));
    }
  }

  Future<void> unlikeProfile(postId, context) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? " ";
    final userID = prefs.getInt('userID') ?? 0;

    final uri = Uri.http(
        'chilamlol.pythonanywhere.com', '/like/unlike/$postId/$userID');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'user-token': token
    };
    final response = await http.post(uri, headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        Future.delayed(Duration(milliseconds: 100));
        Provider.of<AppNotifier>(context, listen: false).callPostAPI();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "There is an issue on our end! Please contact admin for assistance!")));
    }
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
