import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_application/core/utils/app_constants.dart';
import 'package:news_application/features/home/models/top_headlines_body_model.dart';
import 'package:news_application/features/home/models/top_headlines_response.dart';
import 'package:dio/dio.dart';

abstract class HomeServices {
  Future<TopHeadlinesResponse> fetchTopHeadlines(TopHeadlinesBodyModel body);
}

class HomeServicesImple implements HomeServices {
  final aDio = Dio();
  @override
  Future<TopHeadlinesResponse> fetchTopHeadlines(
    TopHeadlinesBodyModel body,
  ) async {
    try {
      final options = Options(
        headers: {"Authorization": "Bearer ${dotenv.env['API_KEY']}"},
      );
      final response = await aDio.get(
        "${AppConstants.baseUrl}${AppConstants.topHeadlinesEndPoint}",
        queryParameters: body.toMap(),
        options: options,
      );
      if (response.statusCode == 200) {
        return TopHeadlinesResponse.fromMap(response.data);
      } else {
        throw Exception("Something went wrong${response.statusMessage}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
