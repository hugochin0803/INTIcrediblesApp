import 'dart:convert';

import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/screens/event/event_detail_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:provider/provider.dart';
import 'package:flutkit/theme/app_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../event/event_full_app.dart';

class DiscussionDetailScreen extends StatefulWidget {
  final int index;
  const DiscussionDetailScreen({Key? key, required this.index})
      : super(key: key);

  @override
  _DiscussionDetailScreen createState() => _DiscussionDetailScreen(index);
}

class _DiscussionDetailScreen extends State<DiscussionDetailScreen> {
  late int index;
  _DiscussionDetailScreen(this.index);
  late CustomTheme customTheme;
  late ThemeData theme;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  Widget build(BuildContext context) {
    final subProvider = Provider.of<AppNotifier>(context);
    List<CommentModel> postList = [];
    if (subProvider.detail['comment'] != null) {
      subProvider.detail['comment'].forEach((val) {
        postList.add(CommentModel.fromJson(val));
      });
    }
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
                                            child: getImage(subProvider
                                                    .detail['userProfile'] ??
                                                "hello"),
                                          ),
                                          FxSpacing.width(10),
                                          Expanded(
                                            flex: 1,
                                            child: FxText.titleSmall(
                                              subProvider.detail['userName'],
                                              fontWeight: 600,
                                            ),
                                          ),
                                          FxText.titleSmall(
                                            subProvider.detail['createdDate'],
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
                                  subProvider.detail['text'],
                                  fontWeight: 500),
                            ),
                            Container(
                              margin: FxSpacing.top(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (subProvider.detail['userLike']) {
                                          } else {}
                                        });
                                      },
                                      child: Icon(
                                        subProvider.detail['userLike']
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: theme.colorScheme.secondary,
                                        size: 20,
                                      )),
                                  FxSpacing.width(8),
                                  FxText.bodySmall(
                                      subProvider.detail['likeCount']
                                          .toString(),
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
                ...List.generate(
                    postList.length,
                    (int index) => Column(
                          children: <Widget>[
                            singleEvent(
                                username: postList[index].userName,
                                userimage: postList[index].userProfile,
                                text: postList[index].text,
                                createdDate: postList[index].createdDate),
                          ],
                        ))
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
                    controller: _controller,
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
                GestureDetector(
                    onTap: () {
                      addComment(subProvider.detail['postId']);
                    },
                    child: Container(
                      margin: FxSpacing.left(16),
                      child: FxText.bodySmall("Post",
                          color: theme.colorScheme.primary.withAlpha(200),
                          fontWeight: 500),
                    ))
              ],
            ),
          ),
        ]));
  }

  Future<void> addComment(postId) async {
    final prefs = await SharedPreferences.getInstance();

    int userID = prefs.getInt('userID') ?? 0;
    String token = prefs.getString('token') ?? " ";

    final uri = Uri.http('chilamlol.pythonanywhere.com', '/comment/add');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'user-token': token
    };

    final body = {"text": _controller.text, "userId": userID, "postId": postId};
    final jsonString = json.encode(body);

    final response = await http.post(uri, headers: headers, body: jsonString);

    if (response.statusCode == 201) {
      setState(() {
        _controller.clear();
        FocusManager.instance.primaryFocus?.unfocus();
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

  Widget singleEvent({
    required String username,
    required String userimage,
    required String text,
    required String createdDate,
  }) {
    final subProvider = Provider.of<AppNotifier>(context);
    return FxCard(
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
                                  fontSize: 12,
                                  fontWeight: 600,
                                ),
                              ),
                              FxText.titleSmall(
                                createdDate,
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
                    text,
                    fontWeight: 500,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PostModel {
  late int approval;
  late List<CommentModel> comments;
  late String createdDate;
  late String file;
  late String image;
  late int likeCount;
  late String modifiedDate;
  late int postId;
  late int status;
  late String text;
  late int userId;
  late String userName;
  late String userProfile;

  PostModel(
      {required this.approval,
      required this.comments,
      required this.createdDate,
      required this.file,
      required this.image,
      required this.likeCount,
      required this.modifiedDate,
      required this.postId,
      required this.status,
      required this.text,
      required this.userId,
      required this.userName,
      required this.userProfile});

  PostModel.fromJson(Map<String, dynamic> json) {
    if (json['comment'] != null) {
      comments = <CommentModel>[];
      json['comment'].forEach((v) {
        comments.add(CommentModel.fromJson(v));
      });
    }
    approval = json['approval'];
    createdDate = json['createdDate'];
    file = json['file'];
    image = json['image'];
    likeCount = json['likeCount'];
    modifiedDate = json['modifiedDate'];
    postId = json['postId'];
    status = json['status'];
    text = json['text'];
    userId = json['userId'];
    userName = json['userName'];
    userProfile = json['userProfile'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (comments != null) {
      data['comment'] = comments.map((v) => v.toJson()).toList();
    }

    data['approval'] = approval;
    data['createdDate'] = createdDate;
    data['file'] = file;
    data['image'] = image;
    data['likeCount'] = likeCount;
    data['modifiedDate'] = modifiedDate;
    data['postId'] = postId;
    data['status'] = status;
    data['text'] = text;
    data['userId'] = userId;
    data['userName'] = userName;
    data['userProfile'] = userProfile;
    return data;
  }
}

class CommentModel {
  late int commentId;
  late String createdDate;
  late String modifiedDate;
  late int status;
  late String text;
  late int userId;
  late String userName;
  late String userProfile;

  CommentModel(
      {required this.commentId,
      required this.createdDate,
      required this.modifiedDate,
      required this.status,
      required this.text,
      required this.userId,
      required this.userName,
      required this.userProfile});

  CommentModel.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    createdDate = json['createdDate'];
    modifiedDate = json['modifiedDate'];
    status = json['status'];
    text = json['text'];
    userId = json['userId'];
    userName = json['userName'];
    userProfile = json['userProfile'] ?? "Empty";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentId'] = commentId;
    data['createdDate'] = createdDate;
    data['modifiedDate'] = modifiedDate;
    data['status'] = status;
    data['text'] = text;
    data['userId'] = userId;
    data['userName'] = userName;
    data['userProfile'] = userProfile;
    return data;
  }
}
