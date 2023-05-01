import 'package:mobile_engineering_sample_app/di/di.dart';
import 'package:mobile_engineering_sample_app/news/news.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  NewsRepository,
])
void setUpTestServiceLocator() {
  sl.allowReassignment = true;

  sl.registerSingleton<NewsRepository>(NewsRepository());
  sl.registerSingleton<NewsBloc>(NewsBloc());
}
