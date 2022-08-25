import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starwars/modules/favorites/src/favorites_controller.dart';
import 'package:starwars/modules/films/src/films_controller.dart';
import 'package:starwars/modules/people/src/people_controller.dart';

class FavoriteLayout {
  static Container getContainer(FavoriteController favoriteController,PeopleController peopleController, FilmsController filmsController) {
    return Container(
      child: Expanded(
        child: ListView.builder(
            itemCount: favoriteController.result.length,
            itemBuilder: (BuildContext context, int index) {
              favoriteController.updateListFavorites();
              return Card(
                color: favoriteController.result[index].identificationCode
                        .contains('p')
                    ? Color.fromRGBO(121, 168, 134, 1)
                    : Color.fromARGB(153, 168, 82, 82),
                child: ListTile(
                  trailing: IconButton(
                    color: Color.fromRGBO(223, 31, 74, 0.6),
                    icon: Icon(favoriteController.result[index].isSelected
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      int code = int.parse(favoriteController
                          .result[index].identificationCode
                          .substring(2));

                      if (favoriteController.result[index].identificationCode
                          .contains('p')) {
                        peopleController.columnUpdateIsSelect(code, false);
                      } else if (favoriteController
                          .result[index].identificationCode
                          .contains('f')) {
                        filmsController.columnUpdateIsSelect(code, false);
                      }
                      favoriteController
                          .delete(favoriteController.result[index].code!);
                    },
                  ),
                  title: Text('${favoriteController.result[index].name}',
                      style: TextStyle(color: Colors.white)),
                ),
              );
            }),
      ),
    );
  }
}
