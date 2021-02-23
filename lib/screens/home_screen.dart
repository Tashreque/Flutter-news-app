import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_news/model/article.dart';
import 'package:my_news/networking/network_manager.dart';
import 'package:my_news/widgets/category_based_item.dart';
import 'package:my_news/widgets/list_separators.dart';
import 'package:my_news/widgets/navigation_bar_bottom.dart';
import 'package:my_news/widgets/top_headline_list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Future<List<Article>> articles;
  Future<List<Article>> articlesByCategory;

  // Tab bar controller and tab bar tabs.
  List<String> _tabTextList = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology",
  ];
  final List<Widget> _tabs = [];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _tabTextList.length; i++) {
      _tabs.add(Tab(text: _tabTextList[i]));
    }
    articles = NetworkManager.instance.getTopHeadlines("us");
    articlesByCategory = NetworkManager.instance
        .getTopHeadlines("us", category: _tabTextList[0]);

    // Setup tab controller.
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      print("Tab index = " + _tabController.index.toString());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 28,
            color: Colors.black,
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
      body: FutureBuilder(
        future: Future.wait([articles, articlesByCategory]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Article> data = snapshot.data[0];
            final List<Article> dataByCategory = snapshot.data[1];
            return Center(
              child: Container(
                color: Colors.white,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return TopHeadlineList(
                        articles: data,
                      );
                    } else if (index == 1) {
                      return TabBar(
                        controller: _tabController,
                        labelColor: Colors.blueAccent,
                        unselectedLabelColor: Colors.grey,
                        isScrollable: true,
                        tabs: _tabs,
                      );
                    } else {
                      final dataToDisplay = dataByCategory[index - 2];
                      final localDateTime =
                          DateTime.parse(dataToDisplay.publishedAt).toLocal();
                      final date = DateFormat.yMEd().format(localDateTime);
                      final time = DateFormat.jm().format(localDateTime);

                      return CategoryBasedItem(
                        headline: dataToDisplay.title,
                        subHeadline: dataToDisplay.description,
                        source: dataToDisplay.source.name,
                        author: dataToDisplay.author,
                        date: date,
                        time: time,
                        headlineImageUrl: dataToDisplay.urlToImage,
                      );
                    }
                  },
                  separatorBuilder: (context, index) {
                    return VerticalListSeparator();
                  },
                  itemCount: dataByCategory.length,
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: null,
                backgroundColor: Colors.white,
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
          }
        },
      ),
    );
  }
}
