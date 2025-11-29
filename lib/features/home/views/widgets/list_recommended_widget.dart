import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_application/core/utils/models/article_model.dart';

import 'package:news_application/core/views/widgets/article_item_list.dart';
import 'package:news_application/features/home/home_cubit/home_cubit.dart';

class ListRecommendedWidget extends StatefulWidget {
  const ListRecommendedWidget({super.key, required this.articles});
  final List<Article> articles;

  @override
  State<ListRecommendedWidget> createState() => _ListRecommendedWidgetState();
}

class _ListRecommendedWidgetState extends State<ListRecommendedWidget> {
  late ScrollController recommendedController;
  @override
  void initState() {
    super.initState();
    recommendedController = ScrollController();
    recommendedController.addListener(_onScroll);
  }

  void _onScroll() {
    final cubit = context.read<HomeCubit>();

    if (recommendedController.position.pixels >=
        recommendedController.position.maxScrollExtent - 200) {
      cubit.fetchRecommendedNewsNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return ListView.separated(
        controller: recommendedController,

        separatorBuilder: (context, index) =>
            SizedBox(height: size.height * 0.02),
        itemCount: widget.articles.length + (homeCubit.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= widget.articles.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator.adaptive()),
            );
          }
          final article = widget.articles[index];
          return ArticleItemList(article: article);
        },
      );
  }
}
