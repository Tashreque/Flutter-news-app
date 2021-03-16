import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:my_news/global_variables/global_variables.dart';
import 'package:my_news/screens/home_screen.dart';
import 'package:my_news/screens/news_detail_screen.dart';

void main() {
  if (kIsWeb) {
    print("Running on web");
    currentPlatform = CurrentPlatform.web;
  } else {
    if (Platform.isIOS) {
      print("Running on iOS");
      currentPlatform = CurrentPlatform.iOS;
    } else if (Platform.isAndroid) {
      print("Running on Android!");
      currentPlatform = CurrentPlatform.android;
    } else {
      print("Running on other!");
    }
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        NewsDetailScreen.routeName: (context) => NewsDetailScreen(),
      },
    );
  }
}
