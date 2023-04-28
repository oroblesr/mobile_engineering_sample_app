import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';

class NewsArticle extends Equatable {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  const NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        url,
        urlToImage,
        publishedAt,
      ];

  static BuiltList<NewsArticle> fromJson(Map<String, dynamic> articles) {
    return BuiltList<NewsArticle>.from(
        articles['articles'].map((dynamic article) {
      return NewsArticle(
        title: article['title'] as String? ?? '',
        description: article['description'] as String? ?? '',
        url: article['url'] as String? ?? '',
        urlToImage: article['urlToImage'] as String? ?? '',
        publishedAt: article['publishedAt'] as String? ?? '',
      );
    }));
  }
}
