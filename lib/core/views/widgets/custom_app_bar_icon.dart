import 'package:flutter/material.dart';
import 'package:news_application/core/utils/theme/app_colors.dart';

class CustomAppBarIcon extends StatelessWidget {
  const CustomAppBarIcon({
    super.key,
    required this.iconData,
    this.isPadding = false,
  });
  final IconData iconData;
  final bool isPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.gray200,
        ),
        child: Padding(
          padding: isPadding
              ? const EdgeInsets.all(12.0)  
              : const EdgeInsets.all(0.0),
          child: Icon(iconData),
        ),
      ),
    );
  }
}
