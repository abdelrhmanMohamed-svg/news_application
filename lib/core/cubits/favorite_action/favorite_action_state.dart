part of 'favorite_action_cubit.dart';

@immutable
sealed class FavoriteActionState {
  const FavoriteActionState();
}

final class FavoriteActionInitial extends FavoriteActionState {}

final class DoingFavorite extends FavoriteActionState {
  final String title;
  const DoingFavorite(this.title);
}

final class SetFavoriteLoded extends FavoriteActionState {
  final bool isFavorite;
  final String title;

  const SetFavoriteLoded(this.isFavorite, this.title);
}

final class DoingFavoriteError extends FavoriteActionState {
  final String title;
  final String message;
  const DoingFavoriteError(this.message, this.title);
}
