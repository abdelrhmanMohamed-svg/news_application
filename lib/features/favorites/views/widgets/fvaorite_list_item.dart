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
    final size = MediaQuery.of(context).size;
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);

    return InkWell(
      onTap: () => Navigator.of(
        context,
      ).pushNamed(AppRoutes.articalDetailsRoute, arguments: article),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            Hero(
              tag: article.url ?? (article.title! + article.publishedAt!),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CachedNetworkImage(
                  height: size.height * 0.15,
                  width: size.width * 0.4,
                  fit: BoxFit.cover,
                  imageUrl: article.urlToImage ?? "",
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator.adaptive()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    article.source?.name ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            BlocBuilder<FavoriteCubit, FavoriteState>(
              bloc: favoriteCubit,
              buildWhen: (previous, current) =>
                  (current is FavoriteDeleted &&
                      current.title == article.title) ||
                  (current is FavoriteDeleting &&
                      current.title == article.title),
              builder: (context, state) {
                if (state is FavoriteDeleting) {
                  return Transform.scale(
                    scale: 0.5,
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                return IconButton(
                  onPressed: () async =>
                      await favoriteCubit.deleteFavorite(article),
                  icon: Icon(Icons.favorite, color: Colors.black),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
