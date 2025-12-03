import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/core/utils/models/article_model.dart';
import 'package:news_application/core/utils/routes/app_routes.dart';
import 'package:news_application/features/favorites/favorite_cubit/favorite_cubit.dart';
import 'package:news_application/features/favorites/views/pages/favorite_page.dart';
import 'package:news_application/features/home/home_cubit/home_cubit.dart';
import 'package:news_application/features/home/views/pages/artical_details_page.dart';
import 'package:news_application/features/home/views/pages/home_page.dart';
import 'package:news_application/features/search/search_cubit/search_cubit.dart';
import 'package:news_application/features/search/views/pages/search_page.dart';
import 'package:news_application/splash_screen.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
      case AppRoutes.favoriteRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) {
              final favoriteCubit = FavoriteCubit();
              favoriteCubit.getFavoriteNews();
              return favoriteCubit;
            },
            child: const FavoritePage(),
          ),
          settings: settings,
        );
      case AppRoutes.searchRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) {
              final searchCubit = SearchCubit();
              searchCubit.searchNews("all");
              return searchCubit;
            },
            child: const SearchPage(),
          ),
          settings: settings,
        );

      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) {
              final homeCubit = HomeCubit();
              homeCubit.fetchTopHeadlines();
              homeCubit.fetchRecommendedNewsInitial();
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
