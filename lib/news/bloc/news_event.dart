part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class LoadNews extends NewsEvent {
  const LoadNews();
}

class NewsUpdated extends NewsEvent {
  const NewsUpdated(this.newsArticle);

  final BuiltList<NewsArticle> newsArticle;

  @override
  List<Object> get props => [newsArticle];
}

class NewsNotFound extends NewsEvent {
  const NewsNotFound({required this.reason});

  final String reason;

  @override
  List<Object> get props => [reason];
}

class ToggleSaveArticle extends NewsEvent {
  const ToggleSaveArticle(this.article);

  final NewsArticle article;

  @override
  List<Object> get props => [article];
}
