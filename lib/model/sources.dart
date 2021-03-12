import 'package:my_news/model/news_source.dart';

class Sources {
  List<NewsSource> sources;

  Sources.fromJson(Map<String, dynamic> json) {
    List<dynamic> sourceListJson = json['sources'];
    sources = sourceListJson.map((each) => NewsSource.fromJson(each)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final List<dynamic> sourcesJson =
        sources.map((each) => each.toJson()).toList();
    data['sources'] = sourcesJson;
    return data;
  }
}
