import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_engineering_sample_app/generated/l10n.dart';
import 'package:mobile_engineering_sample_app/ui/ui.dart';
import 'package:mobile_engineering_sample_app/utils/utils.dart';

class NewsApp extends StatelessWidget {
  const NewsApp() : super(key: NewsAppKeys.newsApp);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BestByApp',
      localizationsDelegates: const [
        // ... app-specific localization delegate[s] here
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: LightTheme.themeData,
      darkTheme: DarkTheme.themeData,
      routes: {
        AppRoutes.home: (context) => _homeRoute(),
      },
    );
  }

  Widget _homeRoute() {
    return const NewsApp();
  }
}
