import 'package:starwars/database/database.dart';
import 'package:starwars/modules/favorites/src/models/favorites_entity.dart';

abstract class FavoriteManager {

  static Future<void> save(FavoriteEntity favorite) async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final favoriteDAO = database.favoriteDAO;
    FavoriteEntity? favoriteEntity = await favoriteDAO.getByName(favorite.name);

    if (favoriteEntity == null) {
      await favoriteDAO.save(favorite);      
    }

  }

  static Stream<FavoriteEntity?> findOne(int code) async* {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final favoriteDAO = database.favoriteDAO;
    yield* favoriteDAO.findOne(code);
  }

  static Future<List<FavoriteEntity>> findAll() async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final favoriteDAO = database.favoriteDAO;
    return favoriteDAO.findAll();
  }

  static Future<void> delete(int code) async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final favoriteDAO = database.favoriteDAO;
    favoriteDAO.delete(code);
  }

  static Future<void> deleteByIdentificationCode(String identificationCode) async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final favoriteDAO = database.favoriteDAO;
    favoriteDAO.deleteByIdentificationCode(identificationCode);
  }

}
