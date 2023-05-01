import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:mobile_engineering_sample_app/news/news.dart';
import 'package:path_provider/path_provider.dart';

// ambient variable to access the service locator
final sl = GetIt.instance;

Future<void> setUpServiceLocator() async {
  sl.registerSingleton<NewsRepository>(NewsRepository());
  sl.registerSingleton<NewsBloc>(NewsBloc());

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [NewsArticleSchema],
    directory: dir.path,
  );

  sl.registerSingleton<Isar>(isar);
}
