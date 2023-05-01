import 'package:built_collection/built_collection.dart';
import 'package:mobile_engineering_sample_app/news/news.dart';

class MockNews {
  const MockNews._();

  static const onlineArticle = NewsArticle(
    title: "Online Title",
    content: "Content",
    description: "Description",
    url: "url",
    urlToImage: "urlToImage",
    publishedAt: "publishedAt",
    isSaved: false,
  );

  static const savedOnlineArticle = NewsArticle(
    title: "Online Title",
    content: "Content",
    description: "Description",
    url: "url",
    urlToImage: "urlToImage",
    publishedAt: "publishedAt",
    isSaved: true,
  );

  static const savedArticle = NewsArticle(
    title: "Saved Title",
    content: "Content",
    description: "Description",
    url: "url2",
    urlToImage: "urlToImage",
    publishedAt: "publishedAt",
    isSaved: true,
  );

  static final newsArticles = [
    onlineArticle,
    savedArticle,
  ].toBuiltList();
}
