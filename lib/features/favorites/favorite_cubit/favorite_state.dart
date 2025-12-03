part of 'favorite_cubit.dart';

sealed class FavoriteState {
  const FavoriteState();
}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {
  final List<Article> fakeArticles;

  const FavoriteLoading(this.fakeArticles);
}

final class FavoriteSuccess extends FavoriteState {
  final List<Article> articles;

  const FavoriteSuccess(this.articles);
}

final class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError(this.message);
}

final class FavoriteDeleting extends FavoriteState {
  final String title;

  const FavoriteDeleting(this.title);
}

final class FavoriteDeleted extends FavoriteState {
  final String title;
  const FavoriteDeleted(this.title);
}

final class FavoriteArticleLoading extends FavoriteState {
  final String title;
  const FavoriteArticleLoading(this.title);
}

final class SetFavoriteLoded extends FavoriteState {
  final bool isFavorite;
  final String title;

  const SetFavoriteLoded(this.isFavorite, this.title);
}

final class SetFavoriteError extends FavoriteState {
  final String title;
  final String message;
  const SetFavoriteError(this.message, this.title);
}

