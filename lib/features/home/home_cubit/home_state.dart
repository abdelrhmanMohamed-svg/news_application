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
