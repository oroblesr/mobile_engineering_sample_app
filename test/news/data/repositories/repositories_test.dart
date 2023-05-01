import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_engineering_sample_app/news/data/repositories/news_repository.dart';

import '../../../test_service_locator.dart';
import '../models/mock_news.dart';

void main() {
  group('Repositories', () {
    setUp(() {
      setUpTestServiceLocator();
    });

    tearDown(() {});

    test('merge online and offline', () {
      final merged = NewsRepository.mergeNews(
        [MockNews.onlineArticle].toBuiltList(),
        [MockNews.savedArticle].toBuiltList(),
      );
      expect(merged[0].title, MockNews.onlineArticle.title);
      expect(merged[1].title, MockNews.savedArticle.title);
    });

    test('merge online and saved with same url', () {
      final merged = NewsRepository.mergeNews(
        [MockNews.onlineArticle].toBuiltList(),
        [MockNews.savedOnlineArticle].toBuiltList(),
      );
      expect(merged[0].title, MockNews.savedOnlineArticle.title);
      expect(merged.length, 1);
    });
  });
}
