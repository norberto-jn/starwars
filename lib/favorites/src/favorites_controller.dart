import 'package:flutter/widgets.dart';
import 'package:starwars/favorites/src/models/favorites_entity.dart';
import 'package:starwars/favorites/src/services/favorites_manager.dart';

class FavoriteController extends ChangeNotifier {
  
  List<FavoriteEntity> result = [];

  void save(String name, bool isSelected,int identificationCode) async {
    await FavoriteManager.save(FavoriteEntity(null, name, isSelected,identificationCode));
    await updateListFavorites();
    notifyListeners();
  }

  Future<List<FavoriteEntity>> updateListFavorites() async {
    result = await FavoriteManager.findAll();
    notifyListeners();
    return result;
  }

  void delete(int code) async {
    await FavoriteManager.delete(code);
    await updateListFavorites();
    notifyListeners();
  }

  void deleteByIdentificationCode(int identificationCode) async {
    await FavoriteManager.deleteByIdentificationCode(identificationCode);
    await updateListFavorites();
    notifyListeners();
  }

}
