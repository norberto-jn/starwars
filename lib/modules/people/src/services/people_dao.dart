import 'package:floor/floor.dart';
import 'package:starwars/modules/people/src/models/people_entity.dart';

@dao
abstract class PeopleDAO {
  @Query('SELECT * FROM people')
  Future<List<PeopleEntity>> findAll();

  @Query('SELECT * FROM people WHERE code = :code')
  Future<PeopleEntity?> findOne(int code);

  @Query('SELECT * FROM people WHERE name = :name')
  Future<PeopleEntity?> getByName(String name);

  @Insert()
  Future<void> save(PeopleEntity peopleEntity);

  @Query('UPDATE people SET isSelected = :isSelected WHERE code = :code')
  Future<void> columnUpdateIsSelect(int code, bool isSelected);
}
