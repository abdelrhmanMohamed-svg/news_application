import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_application/core/utils/app_constants.dart';
import 'package:news_application/core/utils/helpers.dart';
import 'package:news_application/core/utils/models/article_model.dart';
import 'package:news_application/core/utils/routes/app_routes.dart';
import 'package:news_application/core/utils/theme/app_colors.dart';

class CustomCarousalSliderWidget extends StatefulWidget {
  const CustomCarousalSliderWidget({super.key, required this.articles});
  final List<Article> articles;

  @override
  State<CustomCarousalSliderWidget> createState() =>
      _CustomCarousalSliderWidgetState();
}

class _CustomCarousalSliderWidgetState
    extends State<CustomCarousalSliderWidget> {
  int _current = 0;
  late CarouselSliderController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Widget> imageSliders = widget.articles.map((artical) {
      return InkWell(
        onTap: () => Navigator.of(
          context,
        ).pushNamed(AppRoutes.articalDetailsRoute, arguments: artical),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: Stack(
            children: <Widget>[
              Hero(
                tag: artical.url ?? (artical.title! + artical.publishedAt!),
                child: CachedNetworkImage(
                  imageUrl: artical.urlToImage ?? AppConstants.imgPlaceholder,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 10.0,
                left: 10.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      artical.source!.name ?? "other",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${artical.author ?? "Unknown"}•${getFormattedDate(artical.publishedAt)}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        "${artical.title}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,

                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.articles.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(
                entry.key,
                curve: Curves.easeInOutCirc,
              ),
              child: Container(
                width: _current == entry.key ? 25.0 : 12.0,
                height: _current == entry.key ? 10.0 : 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: _current == entry.key
                      ? BorderRadius.circular(8.0)
                      : null,
                  shape: _current == entry.key
                      ? BoxShape.rectangle
                      : BoxShape.circle,
                  color: _current == entry.key
                      ? AppColors.primary
                      : AppColors.gray,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
