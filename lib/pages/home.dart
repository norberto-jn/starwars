import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:starwars/favorites/src/favorites_controller.dart';
import 'package:starwars/favorites/src/models/favorites_entity.dart';
import 'package:starwars/pages/component/app_bar_layout.dart';
import 'package:starwars/people/src/dto/people.dart';
import 'package:starwars/people/src/people_controller.dart';
import 'package:starwars/people/src/services/people_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final favoriteController = FavoriteController();
  final peopleController = PeopleController();

  List<People> filmes = [
    People(name: 'O click', isSelected: false),
    People(name: 'As branquelas', isSelected: false),
  ];

  List<FavoriteEntity> result = [];

  List<People> favoritos = [];

  @override
  Widget build(BuildContext context) {
    PeoPleManager.getJSONData();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBarLayout(
          context,
          TabBar(
            tabs: [
              Tab(text: 'Filmes'),
              Tab(text: 'Personagens'),
              Tab(text: 'Favoritos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //---------------------------------------
            //--------------- Filmes ----------------
            //---------------------------------------
            Container(
              child: Expanded(
                child: ListView.builder(
                    itemCount: filmes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Color.fromRGBO(27, 27, 27, 0.6),
                        child: ListTile(
                          trailing: IconButton(
                            color: Color.fromRGBO(223, 31, 74, 0.6),
                            icon: Icon(filmes[index].isSelected!
                                ? Icons.favorite
                                : Icons.favorite_border),
                            onPressed: () async => {
                              favoriteController.save(
                                  filmes[index].name!, true, index),
                            },
                          ),
                          title: Text('${filmes[index].name}',
                              style: TextStyle(color: Colors.white)),
                        ),
                      );
                    }),
              ),
            ),

            //---------------------------------------
            //------------ Personagens --------------
            //---------------------------------------
            AnimatedBuilder(
                animation: peopleController,
                builder: (context, container) {
                  peopleController.updateListPeoples();
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
                                  icon: Icon(
                                      peopleController.result[index].isSelected
                                          ? Icons.favorite
                                          : Icons.favorite_border),
                                  onPressed: ()  {
                                    if(!peopleController.result[index].isSelected)
                                      favoriteController.save(peopleController.result[index].name,true,peopleController.result[index].code!);
                                    
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
                }),

            //---------------------------------------
            //------------- Favoritos ---------------
            //---------------------------------------
            AnimatedBuilder(
                animation: favoriteController,
                builder: (context, container) {
                  return Container(
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: favoriteController.result.length,
                          itemBuilder: (BuildContext context, int index) {
                            favoriteController.updateListFavorites();

                            return Card(
                              color: Color.fromRGBO(27, 27, 27, 0.6),
                              child: ListTile(
                                trailing: IconButton(
                                  color: Color.fromRGBO(223, 31, 74, 0.6),
                                  icon: Icon(favoriteController
                                          .result[index].isSelected
                                      ? Icons.favorite
                                      : Icons.favorite_border),
                                  onPressed: () {
                                    peopleController.columnUpdateIsSelect(favoriteController.result[index].identificationCode,false);
                                    favoriteController.delete(favoriteController.result[index].code!);
                                  },
                                ),
                                title: Text(
                                    '${favoriteController.result[index].name}',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            );
                          }),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
