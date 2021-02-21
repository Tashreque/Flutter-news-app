import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_news/model/article.dart';
import 'package:my_news/model/top_headlines.dart';

typedef OnSuccess = void Function();

class NetworkManager {
  // Make the constructor private.
  NetworkManager._privateContructor();

  // Declare single one time only instance.
  static final NetworkManager instance = NetworkManager._privateContructor();
  final String _apiKey = "3191677734b945dd866141a14f66c780";
  String url = "";

  // Called
  Future<List<Article>> getTopHeadlines(String country,
      {String category = "", String sources = ""}) async {
    String query = "country=" + country;
    if (sources.isEmpty) {
      query = category.isEmpty ? query : query + ("&category=" + category);
    } else {
      query = "sources=" + sources;
    }

    // Form URL.
    url = "https://newsapi.org/v2/top-headlines?" + query;

    // Make network request.
    Map<String, String> headers = {"X-Api-Key": _apiKey};
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> mapFromJson = jsonDecode(response.body);
      final headlines = TopHeadlines.fromJson(mapFromJson);
      final articles = headlines.articles;
      return articles;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  // Called to obtain a list of all available news publishers.
  Future<void> getAvailableNewsSources() {}
}
