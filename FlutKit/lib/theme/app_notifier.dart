/*
* File : App Theme Notifier (Listener)
* Version : 1.0.0
* */
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutkit/provider/api_service.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/theme/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutkit/extensions/theme_extension.dart';

class AppNotifier extends ChangeNotifier {
  var apiService = new APIService();
  List<dynamic> _locators = [];
  List<dynamic> get locators => this._locators;
  List<dynamic> _locators1 = [];
  List<dynamic> get locators1 => this._locators1;
  List<dynamic> _locators2 = [];
  List<dynamic> get locators2 => this._locators2;
  List<dynamic> _voucher = [];
  List<dynamic> get voucher => this._voucher;
  List<dynamic> _post = [];
  List<dynamic> get post => this._post;
  List<dynamic> _voucherUser = [];
  List<dynamic> get voucherUser => this._voucherUser;
  List<dynamic> _faq = [];
  List<dynamic> get faq => this._faq;
  List<dynamic> _faqdetail = [];
  List<dynamic> get faqdetail => this._faq;
  dynamic _detail = [];
  dynamic get detail => this._detail;
  String token = "";

  set detail(dynamic val) {
    _detail = val;
    notifyListeners();
  }

  AppNotifier() {
    init();
  }

  init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    ThemeType themeType =
        sharedPreferences.getString("theme_mode").toString().toThemeType;
    _changeTheme(themeType);
    notifyListeners();
  }

  updateTheme(ThemeType themeType) {
    _changeTheme(themeType);

    notifyListeners();

    updateInStorage(themeType);
  }

  static void changeFxTheme(ThemeType themeType) {
    if (themeType == ThemeType.light) {
      FxAppTheme.changeThemeType(FxAppThemeType.light);
    } else if (themeType == ThemeType.dark) {
      FxAppTheme.changeThemeType(FxAppThemeType.dark);
    }
  }

  Future<void> updateInStorage(ThemeType themeType) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("theme_mode", themeType.toText);
  }

  void _changeTheme(ThemeType themeType) {
    AppTheme.themeType = themeType;
    AppTheme.customTheme = AppTheme.getCustomTheme(themeType);
    AppTheme.theme = AppTheme.getTheme(themeType);

    AppTheme.changeFxTheme(themeType);
  }

  Future<void> callEvent90API() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? " ";

    try {
      Dio dio = new Dio();
      dio.options.headers['user-token'] = token;

      var response = await dio
          .get('https://chilamlol.pythonanywhere.com/event/upcoming/90');
      // var data = jsonDecode(response.data);
      if (response.data.length > 0) {
        _locators = response.data;
        notifyListeners();
      } else {
        _locators = [];
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> callEventHomeAPI() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? " ";

    try {
      Dio dio = Dio();
      dio.options.headers['user-token'] = token;

      _locators1 = [];
      var response = await dio
          .get('https://chilamlol.pythonanywhere.com/event/upcoming/90');
      var response2 = await dio
          .get('https://chilamlol.pythonanywhere.com/event/upcoming/7');

      if (response.statusCode == 200) {
        if (response.data.length > 0) {
          if (response.data.length > 3) {
            for (var i = 0; i < 3; i++) {
              _locators1.add(response.data[i]);
            }
          } else {
            _locators1 = response.data;
          }

          notifyListeners();
        } else {
          _locators1 = [];
          notifyListeners();
        }
      } else {
        _locators1 = [];
        notifyListeners();
      }

      if (response2.data.length > 0) {
        _locators2 = response2.data;
        notifyListeners();
      } else {
        _locators2 = [];
        notifyListeners();
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> callRewardAPI() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? " ";
    int userID = prefs.getInt('userID') ?? 0;

    try {
      Dio dio = Dio();
      dio.options.headers['user-token'] = token;

      _voucher = [];
      var response =
          await dio.get('https://chilamlol.pythonanywhere.com/voucher/$userID');
      var response2 = await dio
          .get('https://chilamlol.pythonanywhere.com/voucher/active/$userID');

      if (response.data.length > 0) {
        _voucher = response.data;
        notifyListeners();
      } else {
        _voucher = [];
        notifyListeners();
      }

      if (response2.data.length > 0) {
        _voucherUser = response2.data;
        notifyListeners();
      } else {
        _voucherUser = [];
        notifyListeners();
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> callPostAPI() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? " ";
    int userID = prefs.getInt('userID') ?? 0;

    try {
      Dio dio = Dio();
      dio.options.headers['user-token'] = token;

      _post = [];
      var response = await dio
          .get('https://chilamlol.pythonanywhere.com/post/nested/$userID');
      if (response.data.length > 0) {
        _post = response.data;
        notifyListeners();
      } else {
        _post = [];
        notifyListeners();
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> callFAQAPI() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? " ";

    try {
      Dio dio = new Dio();
      dio.options.headers['user-token'] = token;

      _faq = [];
      _faqdetail = [];
      var response =
          await dio.get('https://chilamlol.pythonanywhere.com/faq/nested');
      //var data = jsonDecode(response.data);
      if (response.data.length > 0) {
        _faq = response.data;
        for (int i = 0; i < response.data.length; i++) {
          for (int j = 0; j < response.data[i]['faq'].length; j++) {
            print(response.data[i]['faq'][j]['answer']);
          }
        }
        notifyListeners();
      } else {
        _faq = [];
        _faqdetail = [];
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}

class FAQDetail {
  final String answer;
  final String faqId;
  final String question;
  final String recordStatus;

  FAQDetail({
    required this.answer,
    required this.faqId,
    required this.question,
    required this.recordStatus,
  });

  FAQDetail.fromJson(Map<String, dynamic> json)
      : answer = json['answer'],
        faqId = json['faqId'],
        question = json['question'],
        recordStatus = json['recordStatus'];
}
