part of 'search_cubit.dart';

sealed class SearchState {
  const SearchState();
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {
  final List<Article> fakeArticles;
  const SearchLoading(this.fakeArticles);
}

final class SearchLoaded extends SearchState {
  final List<Article> articles;

  const SearchLoaded(this.articles);
}

final class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);
}
