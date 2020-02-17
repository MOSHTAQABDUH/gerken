
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'Models/localize_and_translate.dart';
import 'package:flutter/cupertino.dart';
import 'page.dart';
Future<void> main() async {
  // if your flutter > 1.7.8 :  ensure flutter activated
  WidgetsFlutterBinding.ensureInitialized();

  LIST_OF_LANGS = ['ar', 'en']; // define languages
  LANGS_DIR = 'langs/'; // define directory
  await translator.init(); // intialize

  runApp(
    LocalizedApp(
      child: Start(),
    ),
  );
}
class Start extends StatefulWidget {
  static MyApp of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<MyApp>());
  const Start({Key navKey}) : super(key: navKey);

  @override
  MyApp createState() => MyApp();
}
class MyApp extends State<Start> {
  /// Keeps index of selected item from drawer
  int _selectedDrawerItem = 0;
  String tempLocale;
  /// Theme brightness
  Brightness _brightness;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.grey
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
//        DefaultCupertinoLocalizations.delegate,
      ],
      locale: translator.locale,
      supportedLocales: translator.locals(),
      home:new InAppWebViewExampleScreen(),
    );
  }





  /// On app launch set correct theme color
  void _setDefaultBrightness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = (prefs.getString("language_code") ?? 'ar');

    switch (languageCode) {
      case "en":
        tempLocale = "en";
        break;
      case "ar":
        tempLocale = "ar";
        break;
      default:
        tempLocale = "ar";
    }
  }
}