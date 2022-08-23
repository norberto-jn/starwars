import 'package:floor/floor.dart';
import 'package:starwars/favorites/src/models/favorites_entity.dart';
import 'package:starwars/people/src/models/people_entity.dart';

@dao
abstract class PeopleDAO {
  @Query('SELECT * FROM people')
  Future<List<PeopleEntity>> findAll();

  @Query('SELECT * FROM people WHERE code = :code')
  Stream<PeopleEntity?> findOne(int code);

  @Insert()
  Future<void> save(PeopleEntity peopleEntity);
}