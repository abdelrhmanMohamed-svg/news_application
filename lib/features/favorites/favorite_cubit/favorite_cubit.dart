import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/core/utils/app_constants.dart';
import 'package:news_application/core/utils/models/article_model.dart';
import 'package:news_application/features/favorites/services/favorite_services.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  // final pref = SharedPrefrencesLocaldata();
  final _favoriteServices = FavoriteServices();
  final List<Article> fakeArticles = List.filled(
    5,
    Article(
      urlToImage: "https://img.jgi.doe.gov/images/home/IMGWebBanner_v4.png",
      title: "there is no news here",
      source: Source(name: "there is no news here"),
      publishedAt: DateTime.now().toString(),
      author: "there is no news here",
      content: "there is no news here",
    ),
  );
  Future<void> getFavoriteNews() async {
    emit(FavoriteLoading(fakeArticles));
    try {
      final favoriteList = await _getFavorite();
      emit(FavoriteSuccess(favoriteList));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> deleteFavorite(Article article) async {
    emit(FavoriteDeleting(article.title ?? ""));
    try {
      final favoriteList = await _getFavorite();
      final index = favoriteList.indexWhere(
        (item) => item.title == article.title,
      );
      favoriteList.remove(favoriteList[index]);
      final list = favoriteList;
      await _favoriteServices.saveFavoriteArticle(
        AppConstants.favoriteKey,
        list,
      );
      emit(FavoriteDeleted(article.title ?? ""));
      emit(FavoriteSuccess(favoriteList));
    } catch (e) {
      emit(FavoriteError(e.toString()));
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
