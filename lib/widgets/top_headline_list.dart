import 'package:flutter/material.dart';
import 'package:my_news/global_variables/global_variables.dart';
import 'package:my_news/model/article.dart';
import 'package:my_news/screens/news_detail_screen.dart';
import 'package:my_news/widgets/list_separators.dart';
import 'package:my_news/widgets/top_headline_item.dart';
import 'package:my_news/helper/string_extension.dart';

class TopHeadlineList extends StatelessWidget {
  final List<Article> articles;
  const TopHeadlineList({Key key, this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double listHeight =
        currentPlatform == CurrentPlatform.web ? 600 : 520;
    return Container(
      height: listHeight,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final article = articles[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, NewsDetailScreen.routeName,
                    arguments: article);
              },
              child: TopHeadlineItem(
                headline: article.title,
                subHeadline: article.description,
                author: article.author,
                source: article.source.name,
                elapsedTime: article.publishedAt.getTimeDifferenceToNow(),
                headlineImageUrl: article.urlToImage,
              ),
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
