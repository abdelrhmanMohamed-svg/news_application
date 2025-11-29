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

