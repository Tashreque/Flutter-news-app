import 'package:flutter/material.dart';
import 'package:my_news/screens/home_screen.dart';
import 'package:my_news/screens/news_detail_screen.dart';

void main() {
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
