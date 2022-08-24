import 'package:floor/floor.dart';
import 'package:starwars/favorites/src/models/favorites_entity.dart';

@dao
abstract class FavoriteDAO {

  @Query('SELECT * FROM favorite')
  Future<List<FavoriteEntity>> findAll();

  @Query('SELECT * FROM favorite WHERE code = :code')
  Stream<FavoriteEntity?> findOne(int code);

  @Query('SELECT * FROM favorite WHERE name = :name')
  Future<FavoriteEntity?> getByName(String name);

  @Insert()
  Future<void> save(FavoriteEntity favoriteModel);

  @Query('DELETE FROM favorite WHERE code = :code')
  Future<void> delete(int code);

  @Query('DELETE FROM favorite WHERE identificationCode = :identificationCode')
  Future<void> deleteByIdentificationCode(String identificationCode);

}