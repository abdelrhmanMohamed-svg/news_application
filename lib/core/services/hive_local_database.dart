import 'package:hive_flutter/adapters.dart';
import 'package:news_application/core/utils/app_constants.dart';
import 'package:news_application/core/utils/models/article_model.dart';

class HiveLocalDatabase {
  static Future<void> hiveInit() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ArticleAdapter());
    Hive.registerAdapter(SourceAdapter());
    await Hive.openBox(AppConstants.favoriteKey);
  }

  Future<void> saveData<T>(String key, T value) async {
    final box = Hive.box(AppConstants.favoriteKey);
    await box.put(key, value);
  }

  Future<T> getData<T>(String key) async {
    final box = Hive.box(AppConstants.favoriteKey);
    return box.get(key);
  }

  Future<void> deleteData(String key) async {
    final box = Hive.box(AppConstants.favoriteKey);
    await box.delete(key);
  }
}
