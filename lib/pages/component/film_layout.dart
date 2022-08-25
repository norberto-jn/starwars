import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starwars/modules/favorites/src/favorites_controller.dart';
import 'package:starwars/modules/films/src/films_controller.dart';

abstract class FilmLayout {

  static Container getContainer(FilmsController filmsController,FavoriteController favoriteController){
    return Container(
      child: Expanded(
        child: ListView.builder(
            itemCount: filmsController.result.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Color.fromRGBO(27, 27, 27, 0.6),
                child: ListTile(
                  trailing: IconButton(
                    color: Color.fromRGBO(223, 31, 74, 0.6),
                    icon: Icon(filmsController.result[index].isSelected ? Icons.favorite : Icons.favorite_border),
                    onPressed: () {
                      if (!filmsController.result[index].isSelected)
                        favoriteController.save(filmsController.result[index].name,true,"f-${filmsController.result[index].code!}");
                      filmsController.columnUpdateIsSelect(filmsController.result[index].code!,!filmsController.result[index].isSelected);
                    },
                ),
                title: Text('${filmsController.result[index].name}',style: TextStyle(color: Colors.white)),
              ),
            );
          }
        ),
      ),
    );
  }
}