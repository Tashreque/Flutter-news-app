import 'package:flutter/material.dart';
import 'package:my_news/widgets/navigation_bar_bottom.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 28,
            color: Colors.white,
          ),
          onPressed: null,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: NavigationBarBottom(
            title: "Top Headlines",
          ),
        ),
      ),
    );
  }
}
