import 'package:floor/floor.dart';
import 'package:starwars/modules/films/src/models/films_entity.dart';

@dao
abstract class FilmsDAO {

  @Query('SELECT * FROM films')
  Future<List<FilmsEntity>> findAll();

  @Query('SELECT * FROM films WHERE code = :code')
  Future<FilmsEntity?> findOne(int code);

  @Query('SELECT * FROM films WHERE name = :name')
  Future<FilmsEntity?> getByName(String name);

  @Insert()
  Future<void> save(FilmsEntity peopleEntity);

  @Query('UPDATE films SET isSelected = :isSelected WHERE code = :code')
  Future<void> columnUpdateIsSelect(int code, bool isSelected);

}
