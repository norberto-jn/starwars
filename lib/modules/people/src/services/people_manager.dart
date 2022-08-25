import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:starwars/database/database.dart';
import 'package:starwars/modules/favorites/src/services/favorites_manager.dart';
import 'package:starwars/modules/people/src/dto/people.dart';
import 'package:starwars/modules/people/src/models/people_entity.dart';

abstract class PeoPleManager {

  static Future<String> getJSONData() async {

    var url = Uri.https("swapi.dev", "/api/people");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      for (var item in jsonResponse['results']) {
        People peopleDTO = People.fromJson(item);
        PeopleEntity? peopleEntity = await PeoPleManager.getByName(peopleDTO.name!);

        if (peopleEntity == null)
          await PeoPleManager.save(PeopleEntity(null, peopleDTO.name!, false));
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return "Data obtained successfully";
  }

  static Future<void> save(PeopleEntity people) async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final peopleDAO = database.peopleDAO;
    await peopleDAO.save(people);
  }

  static Future<PeopleEntity?> findOne(int code) async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final peopleDAO = database.peopleDAO;
    return peopleDAO.findOne(code);
  }

  static Future<void> columnUpdateIsSelect(int code, bool isSelected) async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final peopleDAO = database.peopleDAO;
    if(!isSelected) await FavoriteManager.deleteByIdentificationCode("p-$code");
    await peopleDAO.columnUpdateIsSelect(code, isSelected);
  }

  static Future<PeopleEntity?> getByName(String name) async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final peopleDAO = database.peopleDAO;
    return peopleDAO.getByName(name);
  }

  static Future<List<PeopleEntity>> findAll() async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final peopleDAO = database.peopleDAO;
    return peopleDAO.findAll();
  }

}
