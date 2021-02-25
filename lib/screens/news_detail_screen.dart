import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_news/model/article.dart';

const toolbarHeight = 80.0;
const expandedToolbarHeight = 450.0;

class NewsDetailScreen extends StatefulWidget {
  static final routeName = 'news_detail';
  NewsDetailScreen({Key key}) : super(key: key);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() => setState(() {}));
  }

  bool _showTitle() {
    return _scrollController.hasClients &&
        _scrollController.offset > expandedToolbarHeight - toolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    // Extract arguments.
    final Article article = ModalRoute.of(context).settings.arguments;

    return Container(
      color: Colors.white,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            iconTheme: IconThemeData(
              color: _showTitle() ? Colors.black : Colors.white,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            title: _showTitle()
                ? Text(
                    article.title,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: TextStyle(color: Colors.black),
                  )
                : null,
            flexibleSpace: FlexibleSpaceBar(
              title: _showTitle()
                  ? null
                  : Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(article.title),
                        ],
                      ),
                    ),
              centerTitle: true,
              background: CachedNetworkImage(
                imageUrl: article.urlToImage,
                fit: BoxFit.cover,
              ),
            ),
            expandedHeight: expandedToolbarHeight,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: (index % 2 == 0)
                      ? Container(
                          color: Colors.orange,
                          child: Center(
                            child: Text(
                              article.content.,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(height: 10),
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
