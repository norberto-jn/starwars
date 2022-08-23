import 'package:floor/floor.dart';
import 'package:starwars/favorites/src/models/favorites_entity.dart';

@dao
abstract class FavoriteDAO {
  @Query('SELECT * FROM favorite')
  Future<List<FavoriteEntity>> findAll();

  @Query('SELECT * FROM favorite WHERE code = :code')
  Stream<FavoriteEntity?> findOne(int code);

  @Insert()
  Future<void> save(FavoriteEntity favoriteModel);
}
