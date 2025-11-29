import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/core/utils/models/article_model.dart';
import 'package:news_application/features/search/models/search_body_model.dart';
import 'package:news_application/features/search/services/search_services.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
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
  final _searchServices = SearchServicesImpl();
  Future<void> searchNews(String keyWord) async {
    emit(SearchLoading(fakeArticles));
    try {
      final body = SearchBodyModel(q: keyWord);
      final response = await _searchServices.searchNews(body);
      final articles = response.articles;
      emit(SearchLoaded(articles ?? []));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
