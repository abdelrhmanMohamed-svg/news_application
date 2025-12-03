import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_application/core/utils/app_constants.dart';
import 'package:news_application/core/utils/models/article_model.dart';
import 'package:news_application/features/favorites/services/favorite_services.dart';

part 'favorite_action_state.dart';

class FavoriteActionCubit extends Cubit<FavoriteActionState> {
  FavoriteActionCubit() : super(FavoriteActionInitial());
  final _favoriteServices = FavoriteServices();

  Future<void> setFavorite(Article article) async {
    emit(DoingFavorite(article.title ?? ""));
    try {
      //article -> map -> string

      final favoriteList = await _getFavorite();
      if (favoriteList.isNotEmpty) {
        final isFavorite = favoriteList.any(
          (favoriteArticle) => favoriteArticle.title == article.title,
        );
        if (isFavorite) {
          final index = favoriteList.indexWhere(
            (item) => item.title == article.title,
          );
          favoriteList.remove(favoriteList[index]);
        } else {
          favoriteList.add(article);
        }

        await _favoriteServices.saveFavoriteArticle(
          AppConstants.favoriteKey,
          favoriteList,
        );

        emit(SetFavoriteLoded(!isFavorite, article.title ?? ""));
      } else {
        favoriteList.add(article);

        await _favoriteServices.saveFavoriteArticle(
          AppConstants.favoriteKey,
          favoriteList,
        );
        emit(SetFavoriteLoded(true, article.title ?? ""));
      }
    } catch (e) {
      emit(DoingFavoriteError(e.toString(), article.title ?? ""));
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
