// database.dart

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:starwars/modules/favorites/src/models/favorites_entity.dart';
import 'package:starwars/modules/favorites/src/services/favorites_dao.dart';
import 'package:starwars/modules/films/src/models/films_entity.dart';
import 'package:starwars/modules/films/src/services/films_dao.dart';
import 'package:starwars/modules/people/src/models/people_entity.dart';
import 'package:starwars/modules/people/src/services/people_dao.dart';


part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [FavoriteEntity,PeopleEntity,FilmsEntity])
abstract class AppDatabase extends FloorDatabase {
  FavoriteDAO get favoriteDAO;
  PeopleDAO get peopleDAO;
  FilmsDAO get filmsDAO;  
}
