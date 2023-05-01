import 'dart:async';

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
    on<ToggleSaveArticle>(_onToggleSaveArticle);
  }

  Timer? timer;

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }

  void _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    emit(const NewsState.loading());
    await _refreshNews();
  }

  void _onNewsUpdated(NewsUpdated event, Emitter<NewsState> emit) {
    emit(NewsState.loaded(event.newsArticle));
  }

  void _onNewsNotFound(NewsNotFound event, Emitter<NewsState> emit) {
    emit(NewsState.failed(reason: event.reason));
  }

  void _onToggleSaveArticle(
      ToggleSaveArticle event, Emitter<NewsState> emit) async {
    await sl<NewsRepository>().toggleSaveArticle(event.article);
    await _refreshNews();
  }

  Future<void> _fetchNews() async {
    await sl<NewsRepository>().getNews();
  }

  Future<void> _setTimer() async {
    const fiveMins = Duration(minutes: 5);
    timer = Timer.periodic(fiveMins, (Timer t) async {
      await _fetchNews();
    });
  }

  Future<void> _refreshNews() async {
    await _fetchNews();
    await _setTimer();
  }
}
