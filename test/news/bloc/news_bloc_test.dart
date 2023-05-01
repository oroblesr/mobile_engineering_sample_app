import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_engineering_sample_app/news/news.dart';

import '../../test_service_locator.dart';

void main() {
  group('newsBloc', () {
    late NewsBloc newsBloc;
    setUp(() {
      setUpTestServiceLocator();

      newsBloc = NewsBloc();
    });

    tearDown(() {
      newsBloc.close();
    });

    test('initial state is correct', () {
      expect(newsBloc.state, const NewsState.uninitialized());
    });

    group('NewsNotFound', () {
      blocTest<NewsBloc, NewsState>(
        'emits [failed] on failedToLoad',
        build: () {
          return newsBloc;
        },
        act: (NewsBloc bloc) async => bloc.add(
          const NewsNotFound(reason: 'NewsArticle not found'),
        ),
        expect: () => <NewsState>[
          const NewsState.failed(reason: 'NewsArticle not found'),
        ],
      );
    });
  });
}
