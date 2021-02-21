import 'package:flutter/material.dart';
import 'package:my_news/model/article.dart';
import 'package:my_news/widgets/list_separators.dart';
import 'package:my_news/widgets/top_headline_item.dart';

class TopHeadlineList extends StatelessWidget {
  final List<Article> articles;
  const TopHeadlineList({Key key, this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final article = articles[index];
            return TopHeadlineItem(
              headline: article.title,
              subHeadline: article.description,
              author: article.author,
              source: article.source.name,
              headlineImageUrl: article.urlToImage,
            );
          },
          separatorBuilder: (context, index) {
            return HorizontalListSeparator();
          },
          itemCount: articles.length,
        ),
      ),
    );
  }
}
