import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/core/cubits/favorite_action/favorite_action_cubit.dart';
import 'package:news_application/core/services/hive_local_database.dart';
import 'package:news_application/core/utils/app_constants.dart';
import 'package:news_application/core/utils/routes/app_router.dart';
import 'package:news_application/core/utils/routes/app_routes.dart';
import 'package:news_application/core/utils/theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveLocalDatabase.hiveInit();

  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteActionCubit(),
      child: MaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRoutes.splashRoute,
      ),
    );
  }
}
