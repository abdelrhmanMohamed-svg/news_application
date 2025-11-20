import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_application/core/utils/app_constants.dart';
import 'package:news_application/core/utils/routes/app_routes.dart';
import 'package:news_application/core/utils/theme/app_colors.dart';
import 'package:news_application/core/utils/models/news_response.dart';

class ListRecommendedWidget extends StatelessWidget {
  const ListRecommendedWidget({super.key, required this.articles});
  final List<Article> articles;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) =>
          SizedBox(height: size.height * 0.02),
      itemCount: articles.length,

      itemBuilder: (context, index) {
        final article = articles[index];
        final parserdDate = DateTime.parse(
          article.publishedAt ?? DateTime.now().toString(),
        );
        final formattedDate = DateFormat.yMMMd().format(parserdDate);

        return InkWell(
          onTap: () => Navigator.of(
            context,
          ).pushNamed(AppRoutes.articalDetailsRoute, arguments: article),
          child: Row(
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
                        "${article.author} • $formattedDate",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: AppColors.gray),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
