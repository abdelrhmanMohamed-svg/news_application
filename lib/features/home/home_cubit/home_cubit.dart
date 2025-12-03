import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_application/core/utils/app_constants.dart';
import 'package:news_application/core/utils/models/article_model.dart';
import 'package:news_application/features/favorites/services/favorite_services.dart';
import 'package:news_application/features/home/models/top_headlines_body_model.dart';
import 'package:news_application/features/home/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<Article> articlesList = [];
  int page = 1;
  int pageSize = 30;
  bool hasMore = true;
  bool isFetching = false;
  final _homeServices = HomeServicesImple();
  // final pref = SharedPrefrencesLocaldata();
  final _favoriteServices = FavoriteServices();
  final List<Article> fakeArticles = List.generate(
    5,
    (index) => Article(
      urlToImage: "https://img.jgi.doe.gov/images/home/IMGWebBanner_v4.png",
      title: "there is no news here",
      source: Source(name: "there is no news here"),
      publishedAt: DateTime.now().add(Duration(seconds: index)).toString(),
      author: "there is no news here",
      content: "there is no news here",
    ),
  );
  Future<void> fetchTopHeadlines() async {
    emit(TopHeadlinesLoading(fakeArticles));
    try {
      final body = TopHeadlinesBodyModel(
        page: 1,
        pageSize: 6,
        category: "business",
      );
      final response = await _homeServices.fetchTopHeadlines(body);
      final articles = response.articles;
      emit(TopHeadlinesSuccess(articles ?? []));
    } catch (e) {
      emit(TopHeadlinesError(e.toString()));
    }
  }

  // Future<void> fetchRecommendedNews() async {
  //   emit(RecommendedNewsLoading(fakeArticles));
  //   try {
  //     final body = TopHeadlinesBodyModel(page: 1, pageSize: 15);
  //     final response = await _homeServices.fetchTopHeadlines(body);
  //     final articles = response.articles ?? [];
  //     final favoriteList = await _getFavorite();
  //     for (int i = 0; i < articles.length; i++) {
  //       var article = articles[i];
  //       final isFavorite = favoriteList.any(
  //         (favoriteItem) => favoriteItem.title == article.title,
  //       );
  //       if (isFavorite) {
  //         article = article.copyWith(isFavorite: true);
  //         articles[i] = article;
  //       }
  //     }

  //     emit(RecommendedNewsSuccess(articles));
  //   } catch (e) {
  //     emit(RecommendedNewsError(e.toString()));

  //     debugPrint(e.toString());
  //   }
  // }
  Future<void> fetchRecommendedNewsInitial() async {
    page = 1;
    articlesList = [];
    hasMore = true;
    emit(RecommendedNewsLoading(fakeArticles));

    await _loadPage(isInitial: true);
  }

  Future<void> fetchRecommendedNewsNext() async {
    if (isFetching || !hasMore) return;

    page++;
    emit(RecommendedNewsLoadMore(articlesList));

    await _loadPage(isInitial: false);
  }

  Future<void> _loadPage({required bool isInitial}) async {
    isFetching = true;
    try {
      final body = TopHeadlinesBodyModel(page: page, pageSize: pageSize);
      final response = await _homeServices.fetchTopHeadlines(body);

      final newArticles = response.articles ?? [];
      hasMore = newArticles.length == pageSize;
      if (isInitial) {
        articlesList = newArticles;
      } else {
        articlesList.addAll(newArticles);
      }

      final favorites = await _getFavorite();
      for (int i = 0; i < articlesList.length; i++) {
        final isFavorite = favorites.any(
          (fav) => fav.title == articlesList[i].title,
        );
        if (isFavorite) {
          articlesList[i] = articlesList[i].copyWith(isFavorite: true);
        }
      }

      emit(RecommendedNewsSuccess(List.from(articlesList), hasMore));
    } catch (e) {
      if (!isInitial) page--; // لو فشل ارجع خطوة
      emit(RecommendedNewsError(e.toString()));
    } finally {
      isFetching = false;
    }
  }

  Future<dynamic> _getFavorite() async {
    final favoriteList = await _favoriteServices.getFavoriteArticle(
      AppConstants.favoriteKey,
    );
    if (favoriteList == null) {
      return [];
    }

    return favoriteList.map((e) => e as Article).toList();
  }
}
