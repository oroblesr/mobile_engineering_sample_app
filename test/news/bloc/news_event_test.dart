import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_engineering_sample_app/news/news.dart';

import '../data/models/mock_news.dart';

void main() {
  group('NewsEvent', () {
    group('LoadNews', () {
      test('supports value comparisons', () {
        expect(
          const LoadNews().props,
          const LoadNews().props,
        );
        expect(
          const LoadNews(),
          const LoadNews(),
        );
      });
    });

    group('NewsUpdated', () {
      test('supports value comparisons', () {
        expect(
          NewsUpdated(MockNews.newsArticles).props,
          NewsUpdated(MockNews.newsArticles).props,
        );
        expect(
          NewsUpdated(MockNews.newsArticles),
          NewsUpdated(MockNews.newsArticles),
        );
      });
    });

    group('NewsNotFound', () {
      test('supports value comparisons', () {
        expect(
          const NewsNotFound(reason: 'test').props,
          const NewsNotFound(reason: 'test').props,
        );
        expect(
          const NewsNotFound(reason: 'test'),
          const NewsNotFound(reason: 'test'),
        );
      });
    });

    group('ToggleSaveArticle', () {
      test('supports value comparisons', () {
        expect(
          const ToggleSaveArticle(MockNews.onlineArticle).props,
          const ToggleSaveArticle(MockNews.onlineArticle).props,
        );
        expect(
          const ToggleSaveArticle(MockNews.savedArticle),
          const ToggleSaveArticle(MockNews.savedArticle),
        );
      });
    });
  });
}
