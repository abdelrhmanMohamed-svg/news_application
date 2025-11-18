import 'package:flutter/material.dart';
import 'package:news_application/core/utils/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme() => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
  );
}
