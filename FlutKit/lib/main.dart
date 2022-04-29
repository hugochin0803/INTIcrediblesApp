/*
* File : Main File
* Version : 1.0.0
* */

import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/theme/app_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/themes/app_theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutkit/screens/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutkit/screens/event/event_full_app.dart';

Future<void> main() async {
  //You will need to initialize AppThemeNotifier class for theme changes.
  WidgetsFlutterBinding.ensureInitialized();

  AppTheme.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userID = prefs.getInt('userID');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(ChangeNotifierProvider<AppNotifier>(
      create: (context) => AppNotifier(),
      child: ChangeNotifierProvider<FxAppThemeNotifier>(
        create: (context) => FxAppThemeNotifier(),
        child: userID == null ? MyApp() : Dashboard(),
      ),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (BuildContext context, AppNotifier value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          home: Login2Screen(),
        );
      },
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (BuildContext context, AppNotifier value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          home: EventFullApp(),
        );
      },
    );
  }
}
