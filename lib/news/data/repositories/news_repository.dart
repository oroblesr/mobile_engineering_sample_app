import 'dart:convert' as convert;
import 'package:built_collection/built_collection.dart';
import 'package:isar/isar.dart';
import 'package:mobile_engineering_sample_app/di/di.dart';
import 'package:mobile_engineering_sample_app/news/news.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_engineering_sample_app/utils/utils.dart';

class NewsRepository {
  Future<void> getNews() async {
    final onlineNews = await _getOnlineNews();
    final savedNews = await _getSavedNews();

    sl<NewsBloc>()
        .add(NewsUpdated(NewsRepository.mergeNews(onlineNews, savedNews)));
  }

  Future<void> toggleSaveArticle(NewsArticle article) async {
    final savedArticles = await sl<Isar>().newsArticles.where().findAll();
    final index =
        savedArticles.indexWhere((element) => element.url == article.url);

    if (index == -1) {
      sl<Isar>().writeTxn(() async =>
          await sl<Isar>().newsArticles.put(article.copyWith(isSaved: true)));
    } else {
      final id = savedArticles[index].id;
      if (id != null) {
        sl<Isar>()
            .writeTxn(() async => await sl<Isar>().newsArticles.delete(id));
      }
    }
  }

  static BuiltList<NewsArticle> mergeNews(
      BuiltList<NewsArticle>? onlineNews, BuiltList<NewsArticle>? savedNews) {
    if (onlineNews == null && savedNews != null) {
      return savedNews;
    } else if (onlineNews != null && savedNews == null) {
      return onlineNews;
    } else if (onlineNews == null && savedNews == null) {
      return BuiltList();
    }
    var mergedNews = <String, NewsArticle>{};

    for (var onlineArticle in onlineNews!) {
      mergedNews[onlineArticle.url] = onlineArticle;
    }

    for (var savedArticle in savedNews!) {
      mergedNews[savedArticle.url] = savedArticle;
    }

    return mergedNews.values.toBuiltList();
  }

  Future<BuiltList<NewsArticle>?> _getOnlineNews() async {
    BuiltList<NewsArticle>? onlineArticles;
    // GET https://newsapi.org/v2/top-headlines?country=us&apiKey=API_KEY
    var url = Uri.https('newsapi.org', '/v2/top-headlines',
        {'country': 'us', 'apiKey': ApiKeys.newsOrg});
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      onlineArticles = NewsArticle.fromJson(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return onlineArticles;
  }

  Future<BuiltList<NewsArticle>?> _getSavedNews() async {
    final savedArticles = await sl<Isar>().newsArticles.where().findAll();

    return savedArticles.toBuiltList();
  }
}
