import 'package:flutter/material.dart';
import 'package:news_application/core/utils/routes/app_routes.dart';
import 'package:news_application/features/home/views/pages/home_page.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
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
