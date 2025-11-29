import 'package:news_application/core/services/hive_local_database.dart';

class FavoriteServices {
  final HiveLocalDatabase hiveLocalDatabase = HiveLocalDatabase();
  Future<void> saveFavoriteArticle(String key, List<dynamic> value) async {
    await hiveLocalDatabase.saveData<List<dynamic>>(key, value);
  }

  Future<List<dynamic>?> getFavoriteArticle(String key) async {
    return await hiveLocalDatabase.getData<List<dynamic>?>(key);
  }

  Future<void> deleteFavoriteArticle(String key) async {
    await hiveLocalDatabase.deleteData(key);
  }
}
