import 'dart:async';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:news/article.dart';

class NewsBloc {
  final Dio dio = Dio();
  final StreamController<List<Article>> _articlesStreamController =
  StreamController<List<Article>>();

  Stream<List<Article>> get articlesStream => _articlesStreamController.stream;

  Future<void> fetchArticles(String search, String apiKey,DateTime startDate,DateTime endDate) async {
    try {
      String formattedStart = DateFormat('yyyy-MM-dd').format(startDate);
      String formattedEnd = DateFormat('yyyy-MM-dd').format(endDate);
      List<Article> articlesSearch = [];
      var url =
          "https://newsapi.org/v2/everything?q=$search&from=$formattedStart&to=$formattedEnd&sortBy=popularity&apiKey=$apiKey";
      var response = await dio.get(url);
      var results = response.data["articles"];

      for (var article in results) {
        Article p = Article(
          description: article['description'],
          content: article['content'],
          link: article["url"],
          id: article['source']['id'],
          title: article['title'],
          img: article['urlToImage'],
          author: article['author'],
        );
        articlesSearch.add(p);
      }

      _articlesStreamController.add(articlesSearch);
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    _articlesStreamController.close();
  }
}