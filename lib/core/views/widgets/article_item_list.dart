import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/core/utils/app_constants.dart';
import 'package:news_application/core/utils/helpers.dart';
import 'package:news_application/core/utils/models/article_model.dart';
import 'package:news_application/core/utils/routes/app_routes.dart';
import 'package:news_application/core/utils/theme/app_colors.dart';
import 'package:news_application/core/views/widgets/favorite_button.dart';
import 'package:news_application/features/home/home_cubit/home_cubit.dart';

class ArticleItemList extends StatelessWidget {
  const ArticleItemList({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return InkWell(
      onTap: () => Navigator.of(
        context,
      ).pushNamed(AppRoutes.articalDetailsRoute, arguments: article),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? AppConstants.imgPlaceholder,
                  width: size.width * 0.42,
                  height: size.height * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.directional(
                textDirection: TextDirection.ltr,
                top: 8,
                end: 8,

                child: BlocBuilder<HomeCubit, HomeState>(
                  bloc: homeCubit,
                  buildWhen: (previous, current) =>
                      (current is SetFavoriteLoded &&
                          current.title == article.title) ||
                      (current is SetFavoriteError &&
                          current.title == article.title) ||
                      (current is FavoriteLoading &&
                          current.title == article.title),
                  builder: (context, state) {
                    if (state is FavoriteLoading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is SetFavoriteLoded) {
                      final isFavorite = state.isFavorite;
                      return FavoriteButton(
                        isFavorite: isFavorite,
                        onTap: () async => await homeCubit.setFavorite(article),
                      );
                    }

                    return FavoriteButton(
                      isFavorite: article.isFavorite,
                      onTap: () => homeCubit.setFavorite(article),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(width: size.width * 0.042),
          Expanded(
            child: SizedBox(
              height: size.height * 0.2,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                  Text(
                    article.source!.name ?? "",
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
                  ),
                  Text(
                    article.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "${article.author} • ${getFormattedDate(article.publishedAt)}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: AppColors.gray),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
