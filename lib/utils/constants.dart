import 'package:flutter/widgets.dart';

class TaskKeys {
  const TaskKeys._();

  static const simplePeriodicTask = 'simplePeriodicTask';
}

class NewsAppKeys {
  const NewsAppKeys._();

  static const newsApp = Key('__newsApp__');
  static const homeScreen = Key('__homeScreen__');
}

class AppRoutes {
  const AppRoutes._();

  static const home = '/';
}

class ApiKeys {
  const ApiKeys._();

  // TODO: Add your API key here
  static const newsOrg = '';
}

class LocalStorageKeys {
  const LocalStorageKeys._();

  static const mobileDb = 'mobile_engineering_sample_app_db';
  static const newsArticles = 'newsArticles';
}
