import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/features/favorites/favorite_cubit/favorite_cubit.dart';
import 'package:news_application/features/favorites/views/widgets/empty_favorite_widget.dart';
import 'package:news_application/features/favorites/views/widgets/error_favorite_widget.dart';
import 'package:news_application/features/favorites/views/widgets/favoriteListBuilder.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        bloc: favoriteCubit,
        buildWhen: (previous, current) =>
            current is FavoriteSuccess ||
            current is FavoriteError ||
            current is FavoriteLoading,
        builder: (context, state) {
          if (state is FavoriteLoading) {
            final fakeArticles = state.fakeArticles;
            return Skeletonizer(
              enabled: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Favoritelistbuilder(articles: fakeArticles),
              ),
            );
          } else if (state is FavoriteSuccess) {
            final articles = state.articles;

            return articles.isEmpty
                ? const EmptyFavoriteWidget()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Favoritelistbuilder(articles: articles),
                  );
          } else if (state is FavoriteError) {
            return ErrorFavoriteWidget(
              message: state.message,
              onRetry: () {
                favoriteCubit.getFavoriteNews();
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
