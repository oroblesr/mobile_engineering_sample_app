import 'package:built_collection/built_collection.dart';
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
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
    return HomeScreen();
  }
}

class HomeScreen extends StatelessWidget {
  final _controller = PersistentTabController(initialIndex: 0);

  HomeScreen({super.key = NewsAppKeys.homeScreen});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context: context),
      confineInSafeArea: true,

      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [homeScreenBody(), homeScreenBody(isFavoriteScreen: true)];
  }

  Widget homeScreenBody({bool isFavoriteScreen = false}) {
    return BlocBuilder<NewsBloc, NewsState>(
      bloc: sl<NewsBloc>(),
      builder: (context, state) {
        BuiltList<NewsArticle>? articles;
        if (isFavoriteScreen) {
          articles = state.newsArticles
              ?.where((element) => element.isSaved)
              .toBuiltList();
        } else {
          articles = state.newsArticles;
        }
        final body = articles?.isEmpty ?? true
            ? Center(
                child: Text(
                  isFavoriteScreen
                      ? S.of(context).noNewsFavorite
                      : S.of(context).noNews,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            : ListView(
                shrinkWrap: true,
                children: articles?.map(
                      (article) {
                        return ArticleWidget(article: article);
                      },
                    ).toList() ??
                    [Container()]);
        return RefreshIndicator(
          onRefresh: () {
            sl<NewsBloc>().add(const LoadNews());
            return Future.delayed(const Duration(seconds: 1));
          },
          child: body,
        );
      },
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems(
      {required BuildContext context}) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: (S.of(context).home),
        activeColorPrimary: Colors.purple,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite),
        title: (S.of(context).favorites),
        activeColorPrimary: Colors.purple,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () =>
                      sl<NewsBloc>().add(ToggleSaveArticle(article)),
                  icon: Icon(article.isSaved
                      ? Icons.favorite
                      : Icons.favorite_outline),
                  color: Colors.red,
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
          ],
        ),
      ),
    ));
  }
}
