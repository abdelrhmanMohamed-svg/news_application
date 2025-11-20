import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/core/utils/routes/app_routes.dart';
import 'package:news_application/features/home/home_cubit/home_cubit.dart';
import 'package:news_application/features/home/models/top_headlines_response.dart';
import 'package:news_application/features/home/views/pages/artical_details_page.dart';
import 'package:news_application/features/home/views/pages/home_page.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) {
              final homeCubit = HomeCubit();
              homeCubit.fetchTopHeadlines();
              homeCubit.fetchRecommendedNews();
              return homeCubit;
            },
            child: const HomePage(),
          ),
          settings: settings,
        );
      case AppRoutes.articalDetailsRoute:
        final article = settings.arguments as Article;
        return MaterialPageRoute(
          builder: (context) => ArticalDetailsPage(artical: article),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text("not found page ${settings.name}")),
          ),
          settings: settings,
        );
    }
  }
}
