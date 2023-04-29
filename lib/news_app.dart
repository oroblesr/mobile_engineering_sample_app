import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_engineering_sample_app/di/di.dart';
import 'package:mobile_engineering_sample_app/generated/l10n.dart';
import 'package:mobile_engineering_sample_app/news/news.dart';
import 'package:mobile_engineering_sample_app/ui/ui.dart';
import 'package:mobile_engineering_sample_app/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return const HomeScreen();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key = NewsAppKeys.homeScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: homeScreenBody()),
    );
  }

  Widget homeScreenBody() {
    return BlocBuilder<NewsBloc, NewsState>(
      bloc: sl<NewsBloc>(),
      builder: (context, state) {
        state.newsArticles?.map(
          (article) {
            return ArticleWidget(article: article);
          },
        );
        return ListView(
            shrinkWrap: true,
            children: state.newsArticles?.map(
                  (article) {
                    return ArticleWidget(article: article);
                  },
                ).toList() ??
                [Container()]);
      },
    );
  }
}

class ArticleWidget extends StatelessWidget {
  final NewsArticle article;

  const ArticleWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(article.urlToImage);
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: uri.toString(),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: false,
                  tapHeaderToExpand: false,
                ),
                header: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      article.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                collapsed: Text(
                  article.description,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          article.description,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                onPressed: () async {
                  final articleUri = Uri.tryParse(article.url);
                  if (articleUri != null) {
                    launchUrl(articleUri);
                  }
                },
                child: Text(S.of(context).readMore),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
