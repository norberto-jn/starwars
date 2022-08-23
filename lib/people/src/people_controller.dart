import 'package:flutter/widgets.dart';
import 'package:starwars/people/src/models/people_entity.dart';
import 'package:starwars/people/src/services/people_manager.dart';

class PeopleController extends ChangeNotifier {

  List<PeopleEntity> result = [];

  void save(String name, bool isSelected) async {
    await PeoPleManager.save(PeopleEntity(null, name, isSelected));
    await updateListPeoples();
    notifyListeners();
  }

  Future<List<PeopleEntity>> updateListPeoples() async {
    result = await PeoPleManager.findAll();
    notifyListeners();
    return result;
  }

  Future<void> columnUpdateIsSelect(int code, bool isSelected) async {
    await PeoPleManager.columnUpdateIsSelect(code, isSelected);
    result = await PeoPleManager.findAll();
    notifyListeners();
  }
  
}
