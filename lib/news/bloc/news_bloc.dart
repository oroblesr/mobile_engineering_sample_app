import 'package:built_collection/built_collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_engineering_sample_app/di/di.dart';
import 'package:mobile_engineering_sample_app/news/news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsState.uninitialized()) {
    on<LoadNews>(_onLoadNews);
    on<NewsUpdated>(_onNewsUpdated);
    on<NewsNotFound>(_onNewsNotFound);
  }

  void _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    emit(const NewsState.loading());
    await sl<NewsRepository>().initialize();
    final news = await sl<NewsRepository>().getNews();
    add(NewsUpdated(news));
  }

  void _onNewsUpdated(NewsUpdated event, Emitter<NewsState> emit) {
    emit(NewsState.loaded(event.newsArticle));
  }

  void _onNewsNotFound(NewsNotFound event, Emitter<NewsState> emit) {
    emit(const NewsState.failed(reason: 'NewsArticle not found'));
  }
}
