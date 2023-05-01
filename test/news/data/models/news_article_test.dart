import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_engineering_sample_app/news/news.dart';

import 'mock_news.dart';

void main() {
  setUp(() {
    EquatableConfig.stringify = true;
  });

  group('NewsArticle', () {
    group('Methods', () {
      test('supports value comparisons', () {
        expect(
          MockNews.savedArticle,
          MockNews.savedArticle,
        );
      });

      test('fromJson', () {
        final actual = NewsArticle.fromJson({
          'articles': [
            {
              'title': 'Online Title',
              'content': 'Content',
              'description': 'Description',
              'url': 'url',
              'urlToImage': 'urlToImage',
              'publishedAt': 'publishedAt',
              'isSaved': 'false',
            }
          ]
        }).first;
        expect(actual.title, 'Online Title');
        expect(actual.content, 'Content');
        expect(actual.description, 'Description');
        expect(actual.url, 'url');
        expect(actual.urlToImage, 'urlToImage');
        expect(actual.publishedAt, 'publishedAt');
        expect(actual.isSaved, false);
      });

      test('copyWith', () {
        final actual = MockNews.onlineArticle.copyWith(isSaved: true);
        expect(actual.title, 'Online Title');
        expect(actual.content, 'Content');
        expect(actual.description, 'Description');
        expect(actual.url, 'url');
        expect(actual.urlToImage, 'urlToImage');
        expect(actual.publishedAt, 'publishedAt');
        expect(actual.isSaved, true);
      });
    });
  });
}
