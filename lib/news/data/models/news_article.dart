import 'package:built_collection/built_collection.dart';
import 'package:isar/isar.dart';

part 'news_article.g.dart';

@collection
class NewsArticle {
  const NewsArticle({
    required this.title,
    required this.content,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.isSaved,
    this.id,
  });

  final Id? id;
  final String title;
  final String content;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final bool isSaved;

  static BuiltList<NewsArticle> fromJson(Map<String, dynamic> articles) {
    return BuiltList<NewsArticle>.from(
        articles['articles'].map((dynamic article) {
      return NewsArticle(
        title: article['title'] as String? ?? '',
        content: article['content'] as String? ?? '',
        description: article['description'] as String? ?? '',
        url: article['url'] as String? ?? '',
        urlToImage: article['urlToImage'] as String? ?? '',
        publishedAt: article['publishedAt'] as String? ?? '',
        isSaved: false,
      );
    }));
  }

  NewsArticle copyWith({
    String? title,
    String? content,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    bool? isSaved,
  }) {
    return NewsArticle(
      id: null,
      title: title ?? this.title,
      content: content ?? this.content,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
