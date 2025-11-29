import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_application/core/utils/app_constants.dart';
import 'package:news_application/core/utils/helpers.dart';
import 'package:news_application/core/utils/models/article_model.dart';
import 'package:news_application/core/utils/theme/app_colors.dart';
import 'package:news_application/core/views/widgets/custom_app_bar_icon.dart';

class ArticalDetailsPage extends StatelessWidget {
  const ArticalDetailsPage({super.key, required this.artical});
  final Article artical;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: artical.urlToImage ?? AppConstants.imgPlaceholder,
            fit: BoxFit.cover,
            width: size.width,
            height: size.height * 0.5,
          ),
          Container(
            width: size.width,
            height: size.height * 0.6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,

                colors: [
                  AppColors.black.withOpacity(0.1),
                  AppColors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            right: 10,

            child: SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  CustomAppBarIcon(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    iconData: Icons.arrow_back_ios_new_outlined,
                    isPadding: true,
                  ),
                  Row(
                    children: [
                      CustomAppBarIcon(
                        onTap: () {},
                        iconData: Icons.favorite_border_outlined,
                        isPadding: true,
                      ),
                      CustomAppBarIcon(
                        onTap: () {},
                        iconData: Icons.more_horiz,
                        isPadding: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.3),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: AppColors.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(
                            artical.source!.name ?? "other",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.015),
                      Text(
                        artical.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        "${artical.author ?? "Unknown"} • ${getFormattedDate(artical.publishedAt)}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: size.height * 0.02),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: CachedNetworkImageProvider(
                                  artical.urlToImage ??
                                      AppConstants.imgPlaceholder,
                                ),
                              ),
                              SizedBox(width: size.width * 0.04),

                              Text(
                                artical.source!.name ?? "",
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              SizedBox(width: size.width * 0.03),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: AppColors.white,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: size.height * 0.02),

                          Text(
                            artical.description ?? "",
                            textAlign: TextAlign.justify,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
