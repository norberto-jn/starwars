import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:starwars/favorites/src/favorites_controller.dart';
import 'package:starwars/favorites/src/models/favorites_entity.dart';
import 'package:starwars/pages/component/app_bar_layout.dart';
import 'package:starwars/people/src/dto/people.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = FavoriteController();

  List<People> personagens = [
    People(name: 'jose', isSelected: false),
    People(name: 'Maria', isSelected: false),
  ];

  Future<String> getJSONData() async {
    var url = Uri.https("swapi.dev", "/api/people");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      for (var item in jsonResponse['results']) {
        setState(() {
          personagens.add(People.fromJson(item));
        });
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return "Dados obtidos com sucesso";
  }

  List<People> filmes = [
    People(name: 'O click', isSelected: false),
    People(name: 'As branquelas', isSelected: false),
  ];

  List<FavoriteEntity> result = [];

  List<People> favoritos = [];

  @override
  Widget build(BuildContext context) {
    getJSONData();
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
                              controller.save(filmes[index].name!, true),
                              setState(
                                () => {
                                  favoritos.add(filmes[index]),
                                  filmes[index].isSelected =
                                      filmes[index].isSelected! ? false : true
                                },
                              )
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
            Container(
              child: Expanded(
                child: ListView.builder(
                    itemCount: personagens.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Color.fromRGBO(27, 27, 27, 0.6),
                        child: ListTile(
                          trailing: IconButton(
                            color: Color.fromRGBO(223, 31, 74, 0.6),
                            icon: Icon(personagens[index].isSelected!
                                ? Icons.favorite
                                : Icons.favorite_border),
                            onPressed: () => {
                              controller.save(personagens[index].name!, true),
                              setState(
                                () => {
                                  favoritos.add(People(
                                      name: personagens[index].name,
                                      isSelected: true)),
                                  personagens[index].isSelected =
                                      personagens[index].isSelected!
                                          ? false
                                          : true
                                },
                              )
                            },
                          ),
                          title: Text('${personagens[index].name}',
                              style: TextStyle(color: Colors.white)),
                        ),
                      );
                    }),
              ),
            ),

            //---------------------------------------
            //------------- Favoritos ---------------
            //---------------------------------------
            AnimatedBuilder(
                animation: controller,
                builder: (context, container) {
                  return Container(
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: controller.result.length,
                          itemBuilder: (BuildContext context, int index) {
                            controller.updateListFavorites();

                            return Card(
                              color: Color.fromRGBO(27, 27, 27, 0.6),
                              child: ListTile(
                                trailing: IconButton(
                                  color: Color.fromRGBO(223, 31, 74, 0.6),
                                  icon: Icon(controller.result[index].isSelected
                                      ? Icons.favorite
                                      : Icons.favorite_border),
                                  onPressed: () => false,
                                ),
                                title: Text('${controller.result[index].name}',
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
