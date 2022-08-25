import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starwars/modules/favorites/src/favorites_controller.dart';
import 'package:starwars/modules/people/src/people_controller.dart';

class PeopleLayout{
  static Container getContainer(PeopleController peopleController,FavoriteController favoriteController){
     return Container(
      child: Expanded(
        child: ListView.builder(
            itemCount: peopleController.result.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Color.fromRGBO(27, 27, 27, 0.6),
                child: ListTile(
                  trailing: IconButton(
                    color: Color.fromRGBO(223, 31, 74, 0.6),
                    icon: Icon(peopleController.result[index].isSelected ? Icons.favorite : Icons.favorite_border),
                    onPressed: () {
                      if (!peopleController.result[index].isSelected)
                        favoriteController.save(peopleController.result[index].name,true,"p-${peopleController.result[index].code!}");
                      peopleController.columnUpdateIsSelect(peopleController.result[index].code!,!peopleController.result[index].isSelected);
                    },
                  ),
                  title: Text(
                      '${peopleController.result[index].name}',
                      style: TextStyle(color: Colors.white)),
                ),
              );
            }),
      ),
    );
  }
}