part of 'home_cubit.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {}

final class TopHeadlinesLoading extends HomeState {
  final List<Article> fakeArticles;
  const TopHeadlinesLoading(this.fakeArticles);
}

final class TopHeadlinesSuccess extends HomeState {
  final List<Article> articles;
  const TopHeadlinesSuccess(this.articles);
}

final class TopHeadlinesError extends HomeState {
  final String message;
  const TopHeadlinesError(this.message);
}

final class RecommendedNewsLoading extends HomeState {
  final List<Article> fakeArticles;
  const RecommendedNewsLoading(this.fakeArticles);
}

final class RecommendedNewsSuccess extends HomeState {
  final List<Article> articles;
  final bool hasMore;
  const RecommendedNewsSuccess(this.articles, this.hasMore);
}

final class RecommendedNewsError extends HomeState {
  final String message;
  const RecommendedNewsError(this.message);
}

final class FavoriteLoading extends HomeState {
  final String title;
  const FavoriteLoading(this.title);
}

final class SetFavoriteLoded extends HomeState {
  final bool isFavorite;
  final String title;

  const SetFavoriteLoded(this.isFavorite, this.title);
}

final class SetFavoriteError extends HomeState {
  final String title;
  final String message;
  const SetFavoriteError(this.message, this.title);
}

final class RecommendedNewsLoadMore extends HomeState {
  final List<Article> articles;
  const RecommendedNewsLoadMore(this.articles);
}
