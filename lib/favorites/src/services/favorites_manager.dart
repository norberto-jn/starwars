import 'package:starwars/database/database.dart';
import 'package:starwars/favorites/src/models/favorites_entity.dart';

abstract class FavoriteManager {
  //AppDatabase? database;

  static Future<void> save(FavoriteEntity favorite) async {
    AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final favoriteDAO = database.favoriteDAO;
    await favoriteDAO.save(favorite);
  }

  static Stream<FavoriteEntity?> findOne(int code) async* {
    AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final favoriteDAO = database.favoriteDAO;
    yield* favoriteDAO.findOne(code);
  }

  static Future<List<FavoriteEntity>> findAll() async {
    AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final favoriteDAO = database.favoriteDAO;
    return favoriteDAO.findAll();
  }
}
