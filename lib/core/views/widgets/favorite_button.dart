import 'package:flutter/material.dart';
import 'package:news_application/core/utils/theme/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onTap,
  });
  final bool isFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.gray200,
        ),
        child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      ),
    );
  }
}
