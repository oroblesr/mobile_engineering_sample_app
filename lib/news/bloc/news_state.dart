part of 'news_bloc.dart';

enum NewsStatus {
  failed,
  loading,
  loaded,
  uninitialized,
}

class NewsState extends Equatable {
  const NewsState._({
    this.newsArticles,
    this.reason = '',
    this.status = NewsStatus.uninitialized,
  });

  const NewsState.uninitialized() : this._();

  const NewsState.failed({String reason = ''})
      : this._(status: NewsStatus.failed, reason: reason);

  const NewsState.loading() : this._(status: NewsStatus.loading);

  const NewsState.loaded(BuiltList<NewsArticle> newsArticles)
      : this._(status: NewsStatus.loaded, newsArticles: newsArticles);

  final BuiltList<NewsArticle>? newsArticles;
  final NewsStatus status;
  final String reason;

  @override
  List<Object?> get props => [newsArticles, status, reason];
}
