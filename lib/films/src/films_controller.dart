import 'package:flutter/widgets.dart';
import 'package:starwars/films/src/models/films_entity.dart';
import 'package:starwars/films/src/services/films_manager.dart';

class FilmsController extends ChangeNotifier {

  List<FilmsEntity> result = [];

  void save(String name, bool isSelected) async {
    await FilmsManager.save(FilmsEntity(null, name, isSelected));
    await updateListFilms();
    notifyListeners();
  }

  Future<List<FilmsEntity>> updateListFilms() async {
    result = await FilmsManager.findAll();   
    notifyListeners();
    return result;
  }

  Future<void> columnUpdateIsSelect(int code, bool isSelected) async {
    await FilmsManager.columnUpdateIsSelect(code, isSelected);
    result = await FilmsManager.findAll();
    notifyListeners();
  }
  
}
