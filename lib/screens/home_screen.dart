import 'package:flutter/material.dart';
import 'package:my_news/model/article.dart';
import 'package:my_news/networking/network_manager.dart';
import 'package:my_news/widgets/list_separators.dart';
import 'package:my_news/widgets/navigation_bar_bottom.dart';
import 'package:my_news/widgets/top_headline_list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Article>> articles;

  @override
  void initState() {
    super.initState();
    articles = NetworkManager.instance.getTopHeadlines("us");
    // articles.then((value) {
    //   for (int i = 0; i < value.length; i++) {
    //     print(value[i].content);
    //     print(value[i].urlToImage);
    //     print("\n");
    //   }
    // });
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
        future: articles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Article> data = snapshot.data;
            print(data.toString());
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
                    }
                    return Container(
                      color: Colors.black,
                      height: 80,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return VerticalListSeparator();
                  },
                  itemCount: 1,
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
