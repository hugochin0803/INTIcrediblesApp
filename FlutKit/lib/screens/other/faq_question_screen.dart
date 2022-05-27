import 'dart:convert';

import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Faqcat {
  final String name;
  final List<FAQ> faq;

  Faqcat({required this.name, required this.faq});

  factory Faqcat.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['faq'] as List;
    print(list.runtimeType); //returns List<dynamic>
    List<FAQ> faqList = list.map((i) => FAQ.fromJson(i)).toList();

    return Faqcat(
      name: parsedJson['name'],
      faq: faqList,
    );
  }
}

class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});

  factory FAQ.fromJson(Map<String, dynamic> parsedJson) {
    return FAQ(question: parsedJson['question'], answer: parsedJson['answer']);
  }
}

class FAQQuestionScreen extends StatefulWidget {
  @override
  _FAQQuestionScreenState createState() => _FAQQuestionScreenState();
}

class _FAQQuestionScreenState extends State<FAQQuestionScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  List<bool> _dataExpansionPanel = [false, false, false, false, false];

  late List<String> _content;

  initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _fetchFaq();
    _content = List.generate(
        5,
        (index) => Generator.getParagraphsText(
            paragraph: 2, words: 24, noOfNewLine: 2, withHyphen: true));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                FeatherIcons.chevronLeft,
                size: 20,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            elevation: 4,
            backgroundColor: const Color(0xFFEC3E37),
            automaticallyImplyLeading: false,
            shadowColor: Colors.grey,
            title: Container(
                child: Row(children: <Widget>[
              FxText.bodyLarge(
                "FAQ",
                color: theme.colorScheme.onPrimary,
                fontWeight: 600,
                fontSize: 18,
              ),
            ]))),
        body: Container(
          child: ListView(
            padding: EdgeInsets.only(bottom: 20),
            children: <Widget>[
              ListTile(
                title: FxText.b1("General Question:",
                    color: theme.colorScheme.onBackground, fontWeight: 600),
              ),
              ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.all(0),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _dataExpansionPanel[index] = !isExpanded;
                  });
                },
                animationDuration: Duration(milliseconds: 500),
                children: <ExpansionPanel>[
                  ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: FxText.sh2("What is INTIcredible",
                              color: isExpanded
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onBackground,
                              fontWeight: isExpanded ? 600 : 500),
                        );
                      },
                      body: Container(
                        padding:
                            EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        child: Center(
                          child: FxText.b2(_content[0], fontWeight: 500),
                        ),
                      ),
                      isExpanded: _dataExpansionPanel[0]),
                  ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: FxText.sh2("How do I register a new account",
                              color: isExpanded
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onBackground,
                              fontWeight: isExpanded ? 600 : 500),
                        );
                      },
                      body: Container(
                        padding:
                            EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        child: Center(
                          child: FxText.b2(_content[1], fontWeight: 500),
                        ),
                      ),
                      isExpanded: _dataExpansionPanel[1]),
                  ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: FxText.sh2("How can I reset password",
                              color: isExpanded
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onBackground,
                              fontWeight: isExpanded ? 600 : 500),
                        );
                      },
                      body: Container(
                        padding:
                            EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        child: Center(
                          child: FxText.b2(_content[2], fontWeight: 500),
                        ),
                      ),
                      isExpanded: _dataExpansionPanel[2]),
                  ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: FxText.sh2("How I contact with administrator",
                              color: isExpanded
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onBackground,
                              fontWeight: isExpanded ? 600 : 500),
                        );
                      },
                      body: Container(
                        padding:
                            EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        child: Center(
                          child: FxText.sh2(_content[3], fontWeight: 500),
                        ),
                      ),
                      isExpanded: _dataExpansionPanel[3]),
                  ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: FxText.b1("Where to join an event",
                              color: isExpanded
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onBackground,
                              fontWeight: isExpanded ? 600 : 500),
                        );
                      },
                      body: Container(
                        padding:
                            EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        child: Center(
                          child: FxText.b2(_content[4], fontWeight: 500),
                        ),
                      ),
                      isExpanded: _dataExpansionPanel[4]),
                ],
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 20),
              //   child: Center(
              //     child: FxText.b1("Visit our site",
              //         color: theme.colorScheme.primary, fontWeight: 600),
              //   ),
              // )
            ],
          ),
        ));
  }

  Future<List<Faqcat>> _fetchFaq() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? " ";
    final uri = Uri.http('chilamlol.pythonanywhere.com', '/faq/nested');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'user-token': token
    };
    final response = await http.get(uri, headers: requestHeaders);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((faq) => new Faqcat.fromJson(faq)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _jobsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].position, data[index].company, Icons.work);
        });
  }

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );

  ExpansionPanelList expansion(String title, String subtitle, IconData icon) =>
      ExpansionPanelList(
          expandedHeaderPadding: EdgeInsets.all(0),
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _dataExpansionPanel[index] = !isExpanded;
            });
          },
          animationDuration: Duration(milliseconds: 500),
          children: <ExpansionPanel>[
            ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: FxText.sh2("What is INTIcredible",
                        color: isExpanded
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onBackground,
                        fontWeight: isExpanded ? 600 : 500),
                  );
                },
                body: Container(
                  padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Center(
                    child: FxText.b2(_content[0], fontWeight: 500),
                  ),
                ),
                isExpanded: _dataExpansionPanel[0])
          ]);
}
