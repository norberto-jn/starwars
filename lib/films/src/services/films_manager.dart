import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:starwars/database/database.dart';
import 'package:starwars/favorites/src/services/favorites_manager.dart';
import 'package:starwars/films/src/dto/film_response.dart';
import 'package:starwars/films/src/models/films_entity.dart';

abstract class FilmsManager {
  
  static Future<String> getJSONData() async {
    var url = Uri.https("swapi.dev", "/api/films");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      for (var item in jsonResponse['results']) {
        Film peopleDTO = Film.fromJson(item);
        FilmsEntity? peopleEntity = await FilmsManager.getByName(peopleDTO.name!);

        if (peopleEntity == null)
          await FilmsManager.save(FilmsEntity(null, peopleDTO.name!, false));
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return "Data obtained successfully";
  }

  static Future<void> save(FilmsEntity film) async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final filmsDAO = database.filmsDAO;
    await filmsDAO.save(film);
  }

  static Future<FilmsEntity?> findOne(int code) async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final filmsDAO = database.filmsDAO;
    return filmsDAO.findOne(code);
  }

  static Future<void> columnUpdateIsSelect(int code, bool isSelected) async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final filmsDAO = database.filmsDAO;
    if (!isSelected)
      await FavoriteManager.deleteByIdentificationCode("f-$code");
    await filmsDAO.columnUpdateIsSelect(code, isSelected);
  }

  static Future<FilmsEntity?> getByName(String name) async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final filmsDAO = database.filmsDAO;
    return filmsDAO.getByName(name);
  }

  static Future<List<FilmsEntity>> findAll() async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final filmsDAO = database.filmsDAO;
    return filmsDAO.findAll();
  }
}
