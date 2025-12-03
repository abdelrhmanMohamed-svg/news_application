import 'package:flutter/material.dart';
import 'package:news_application/core/utils/models/article_model.dart';
import 'package:news_application/features/favorites/views/widgets/fvaorite_list_item.dart';

class Favoritelistbuilder extends StatelessWidget {
  const Favoritelistbuilder({super.key, required this.articles});
  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final article = articles[index];
        return FvaoriteListItem(article: article);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 13),
      itemCount: articles.length,
    );
  }
}
