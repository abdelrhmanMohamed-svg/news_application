import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_application/features/home/models/top_headlines_body_model.dart';
import 'package:news_application/features/home/models/top_headlines_response.dart';
import 'package:news_application/features/home/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final _homeServices = HomeServicesImple();
  final List<Article> fakeArticles = List.filled(
    5,
    Article(
      urlToImage: "https://img.jgi.doe.gov/images/home/IMGWebBanner_v4.png",
      title: "there is no news here",
    ),
  );
  Future<void> fetchTopHeadlines() async {
    emit(TopHeadlinesLoading(fakeArticles));
    try {
      final body = TopHeadlinesBodyModel(page: 1, pageSize: 6);
      final response = await _homeServices.fetchTopHeadlines(body);
      final articles = response.articles;
      emit(TopHeadlinesSuccess(articles ?? []));
    } catch (e) {
      debugPrint(e.toString());
      emit(TopHeadlinesError(e.toString()));
    }
  }
}
