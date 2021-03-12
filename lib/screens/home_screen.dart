import 'package:flutter/material.dart';
import 'package:my_news/global_variables/global_variables.dart';
import 'package:my_news/model/article.dart';
import 'package:my_news/networking/network_manager.dart';
import 'package:my_news/screens/news_detail_screen.dart';
import 'package:my_news/screens/options_drawer.dart';
import 'package:my_news/widgets/category_based_item.dart';
import 'package:my_news/widgets/list_separators.dart';
import 'package:my_news/widgets/navigation_bar_bottom.dart';
import 'package:my_news/widgets/top_headline_list.dart';
import 'package:my_news/helper/string_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Future<List<Article>> articles;
  Future<List<Article>> articlesByCategory;

  final List<Widget> _tabs = [];
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    // Add tabs to the tab list.
    for (int i = 0; i < tabTextList.length; i++) {
      _tabs.add(Tab(
        child: Text(
          tabTextList[i],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ));
    }

    // Obtain articles and articlesByCategory by making network request.
    final lastSelectedCountry = getlastSelectedCountry();
    lastSelectedCountry.then((value) {
      articles =
          NetworkManager.instance.getTopHeadlines(countryCodeDictionary[value]);
      articlesByCategory = NetworkManager.instance.getTopHeadlines(
          countryCodeDictionary[value],
          category: tabTextList[0]);
    });

    // Setup tab controller.
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      // Change state when switched to a new tab.
      if (_tabController.indexIsChanging) {
        setState(() {
          // Make network request to get relevant news by category.
          final lastSelectedCountry = getlastSelectedCountry();
          lastSelectedCountry.then((value) {
            articlesByCategory = NetworkManager.instance.getTopHeadlines(
                countryCodeDictionary[value],
                category: tabTextList[_tabController.index]);
          });
        });
      }
    });
  }

  // Retrieve data from UserDefaults (iOS) or SharedPreferences (Android).
  Future<String> getlastSelectedCountry() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final lastSelectedCountry =
        preferences.getString("lastSelectedCountry") ?? "United States";
    return lastSelectedCountry;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: OptionsDrawer(
          selectedCountry: (countryCode) {
            print(countryCode);
            setState(() {
              articles = NetworkManager.instance.getTopHeadlines(countryCode);
              articlesByCategory = NetworkManager.instance
                  .getTopHeadlines(countryCode, category: tabTextList[0]);
            });
          },
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                size: 28,
                color: Colors.black,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
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
                      final date =
                          dataToDisplay.publishedAt.getLocalDateString();
                      final time =
                          dataToDisplay.publishedAt.getLocalTimeString();

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, NewsDetailScreen.routeName,
                              arguments: dataToDisplay);
                        },
                        child: CategoryBasedItem(
                          headline: dataToDisplay.title,
                          subHeadline: dataToDisplay.description,
                          source: dataToDisplay.source.name,
                          author: dataToDisplay.author,
                          date: date,
                          time: time,
                          headlineImageUrl: dataToDisplay.urlToImage,
                        ),
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
