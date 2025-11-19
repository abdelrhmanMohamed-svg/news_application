import 'package:flutter/material.dart';
import 'package:news_application/core/utils/theme/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HeadLineTitleWidget extends StatelessWidget {
  const HeadLineTitleWidget({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final enabled = Skeletonizer.of(context).enabled;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
        ),
        if (enabled)
          Skeleton.keep(
            child: TextButton(
              onPressed: onTap,
              child: Text(
                "View All",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: AppColors.primary),
              ),
            ),
          )
        else
          TextButton(
            onPressed: onTap,
            child: Text(
              "View All",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: AppColors.primary),
            ),
          ),
      ],
    );
  }
}
