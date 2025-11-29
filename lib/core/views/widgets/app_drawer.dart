import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/core/utils/routes/app_routes.dart';
import 'package:news_application/core/utils/theme/app_colors.dart';
import 'package:news_application/features/home/home_cubit/home_cubit.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              child: Text(
                "News App",
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(color: AppColors.white),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home", style: Theme.of(context).textTheme.titleMedium),
            onTap: () {
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.homeRoute).then((value) async {
                return  await Future.wait([
                  homeCubit.fetchTopHeadlines(),
                  homeCubit.fetchRecommendedNewsInitial(),
                ]);
              });
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
              "Favorites",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.favoriteRoute),
          ),
          Divider(),
        ],
      ),
    );
  }
}
