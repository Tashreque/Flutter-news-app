import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_news/global_variables/global_variables.dart';
import 'package:my_news/model/article.dart';
import 'package:my_news/helper/string_extension.dart';
import 'package:my_news/widgets/bordered_box.dart';
import 'package:share/share.dart';

const toolbarHeight = 80.0;
const expandedToolbarHeight = 500.0;

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
    final Widget shareIcon = currentPlatform == CurrentPlatform.iOS
        ? Icon(CupertinoIcons.share)
        : Icon(Icons.share);

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
            actions: currentPlatform != CurrentPlatform.web
                ? [
                    IconButton(
                        icon: shareIcon,
                        onPressed: () {
                          Share.share(article.url);
                        }),
                  ]
                : null,
            flexibleSpace: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                FlexibleSpaceBar(
                  titlePadding: EdgeInsets.all(0),
                  title: _showTitle()
                      ? null
                      : ClipRect(
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16, 8, 16, 33),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Text(
                                  article.title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                  centerTitle: true,
                  background: (article.urlToImage != null)
                      ? CachedNetworkImage(
                          imageUrl: article.urlToImage,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.blueAccent,
                        ),
                ),
                Container(
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
            expandedHeight: expandedToolbarHeight,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return Container(
                    child: Row(
                      children: [
                        article.author != null
                            ? Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: BorderedBox(
                                    stringContent: article.author,
                                    fillColour: Colors.lightBlue[100],
                                    borderColor: Colors.blue,
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Container(),
                              ),
                        article.source.name != null
                            ? Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                                  child: BorderedBox(
                                    stringContent: article.source.name,
                                    borderColor: Colors.green,
                                    fillColour: Colors.lightGreen[100],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Container(),
                              ),
                        article.publishedAt != null
                            ? Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                                  child: BorderedBox(
                                    stringContent: article.publishedAt
                                            .getTimeDifferenceToNow() +
                                        " ago",
                                    fillColour: Colors.orangeAccent[100],
                                    borderColor: Colors.orange,
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Container(),
                              ),
                      ],
                    ),
                  );
                } else if (index == 1) {
                  return article.description != null
                      ? Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                            child: Text(
                              article.description ?? "",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        )
                      : null;
                } else if (index == 2) {
                  return article.content != null
                      ? Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                            child: Text(
                              article.content ?? "",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        )
                      : null;
                } else {
                  return article.url != null
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
                          child: BorderedBox(
                            stringContent: article.url,
                            fillColour: Colors.lightBlue[100],
                            borderColor: Colors.blue,
                          ),
                        )
                      : null;
                }
              },
              childCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
