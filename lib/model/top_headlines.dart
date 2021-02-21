import 'package:my_news/model/article.dart';

class TopHeadlines {
  String status;
  int totalResults;
  List<Article> articles;

  TopHeadlines({
    this.status,
    this.totalResults,
    this.articles,
  });

  TopHeadlines.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    List<dynamic> articlesJson = json['articles'];
    articles = articlesJson.map((each) => Article.fromJson(each)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;

    List<dynamic> articlesJson =
        this.articles.map((each) => each.toJson()).toList();
    data['articles'] = articlesJson;
    return data;
  }
}
