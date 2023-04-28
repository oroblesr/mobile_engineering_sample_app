import 'dart:convert' as convert;
import 'package:built_collection/built_collection.dart';
import 'package:mobile_engineering_sample_app/news/news.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_engineering_sample_app/utils/utils.dart';
import 'package:workmanager/workmanager.dart';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case TaskKeys.simplePeriodicTask:
        print("${TaskKeys.simplePeriodicTask} was executed");
        break;
      case Workmanager.iOSBackgroundTask:
        // print("The iOS background fetch was triggered");
        // Directory? tempDir = await getTemporaryDirectory();
        // String? tempPath = tempDir.path;
        print(
            "You can access other plugins in the background, for example Directory.getTemporaryDirectory()");
        break;
    }

    return Future.value(true);
  });
}

class NewsRepository {
  Future<BuiltList<NewsArticle>> getNews() async {
    await Workmanager().registerOneOffTask(
      TaskKeys.simplePeriodicTask,
      TaskKeys.simplePeriodicTask,
    );

    // GET https://newsapi.org/v2/top-headlines?country=us&apiKey=API_KEY
    var url = Uri.https('newsapi.org', '/v2/top-headlines',
        {'country': 'us', 'apiKey': ApiKeys.newsOrg});
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      final articles = NewsArticle.fromJson(jsonResponse);
      return articles;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return BuiltList<NewsArticle>();
  }

  Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
  }
}
