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
  const RecommendedNewsSuccess(this.articles);

}

final class RecommendedNewsError extends HomeState {
  final String message;
  const RecommendedNewsError(this.message);

}