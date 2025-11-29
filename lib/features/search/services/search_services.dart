import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_application/core/utils/app_constants.dart';
import 'package:news_application/core/utils/models/news_response.dart';
import 'package:news_application/features/search/models/search_body_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class SearchServices {
  Future<NewsResponse> searchNews(SearchBodyModel body);
}

class SearchServicesImpl implements SearchServices {
  final aDio = Dio();

  @override
  Future<NewsResponse> searchNews(SearchBodyModel body) async {
    try {
      aDio.options.baseUrl = AppConstants.baseUrl;
      aDio.interceptors.add(PrettyDioLogger());

      final options = Options(
        headers: {"Authorization": "Bearer ${dotenv.env['API_KEY']}"},
      );

      final response = await aDio.get(
        AppConstants.everyThingEndPoint,
        queryParameters: body.toMap(),

        options: options,
      );
      if (response.statusCode == 200) {
        return NewsResponse.fromMap(response.data);
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      rethrow;
    }
  }
}
