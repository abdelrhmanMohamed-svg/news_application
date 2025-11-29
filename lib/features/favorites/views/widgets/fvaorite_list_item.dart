import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/core/utils/models/article_model.dart';
import 'package:news_application/core/utils/routes/app_routes.dart';
import 'package:news_application/features/favorites/favorite_cubit/favorite_cubit.dart';

class FvaoriteListItem extends StatelessWidget {
  const FvaoriteListItem({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    return ListTile(
      onTap: () => Navigator.of(
        context,
      ).pushNamed(AppRoutes.articalDetailsRoute, arguments: article),
      leading: CachedNetworkImage(
        height: size.height * 0.6,
        width: size.width * 0.3,
        fit: BoxFit.cover,

        imageUrl: article.urlToImage ?? "",
      ),
      title: Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,

        article.title ?? "",
      ),

      trailing: BlocBuilder<FavoriteCubit, FavoriteState>(
        bloc: favoriteCubit,
        buildWhen: (previous, current) =>
            (current is FavoriteDeleted && current.title == article.title) ||
            (current is FavoriteDeleting && current.title == article.title) ||
            (current is FavoriteDeleted && current.title == article.title),
        builder: (context, state) {
          if (state is FavoriteDeleting) {
            return Transform.scale(
              scale: 0.5,
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return InkWell(
            onTap: () async => await favoriteCubit.deleteFavorite(article),
            child: Icon(Icons.favorite),
          );
        },
      ),
    );
  }
}
