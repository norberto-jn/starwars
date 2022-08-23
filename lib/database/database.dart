// database.dart

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:starwars/favorites/src/services/favorites_dao.dart';
import 'package:starwars/favorites/src/models/favorites_entity.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [FavoriteEntity])
abstract class AppDatabase extends FloorDatabase {
  FavoriteDAO get favoriteDAO;
}
