import 'package:get_it/get_it.dart';
import 'package:mobile_engineering_sample_app/news/news.dart';
import 'package:workmanager/workmanager.dart';

// ambient variable to access the service locator
final sl = GetIt.instance;

Future<void> setUpServiceLocator() async {
  sl.registerSingleton<Workmanager>(Workmanager());
  sl.registerSingleton<NewsRepository>(NewsRepository());
  sl.registerSingleton<NewsBloc>(NewsBloc()..add(const LoadNews()));
}
