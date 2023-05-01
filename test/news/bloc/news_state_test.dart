import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_engineering_sample_app/news/news.dart';

import '../data/models/mock_news.dart';

void main() {
  group('NewsState', () {
    group('NewsState.uninitialized', () {
      test('supports value comparisons', () {
        expect(
          const NewsState.uninitialized().props,
          const NewsState.uninitialized().props,
        );
        expect(
          const NewsState.uninitialized(),
          const NewsState.uninitialized(),
        );
      });
    });

    group('NewsState.failed', () {
      test('supports value comparisons', () {
        expect(
          const NewsState.failed(reason: 'reason').props,
          const NewsState.failed(reason: 'reason').props,
        );
        expect(
          const NewsState.failed(reason: 'reason'),
          const NewsState.failed(reason: 'reason'),
        );
      });
    });

    group('NewsState.loading', () {
      test('supports value comparisons', () {
        expect(
          const NewsState.loading().props,
          const NewsState.loading().props,
        );
        expect(
          const NewsState.loading(),
          const NewsState.loading(),
        );
      });
    });

    group('NewsState.loaded', () {
      test('supports value comparisons', () {
        expect(
          NewsState.loaded(MockNews.newsArticles).props,
          NewsState.loaded(MockNews.newsArticles).props,
        );
        expect(
          NewsState.loaded(MockNews.newsArticles),
          NewsState.loaded(MockNews.newsArticles),
        );
      });
    });
  });
}
