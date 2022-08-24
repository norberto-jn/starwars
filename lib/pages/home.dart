import 'package:flutter/material.dart';
import 'package:starwars/favorites/src/favorites_controller.dart';
import 'package:starwars/favorites/src/models/favorites_entity.dart';
import 'package:starwars/films/src/films_controller.dart';
import 'package:starwars/films/src/services/films_manager.dart';
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
  final filmsController = FilmsController();

  List<People> filmes = [
    People(name: 'O click', isSelected: false),
    People(name: 'As branquelas', isSelected: false),
  ];

  List<FavoriteEntity> result = [];

  List<People> favoritos = [];

  @override
  Widget build(BuildContext context) {
    PeoPleManager.getJSONData();
    FilmsManager.getJSONData();

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
            AnimatedBuilder(
                animation: filmsController,
                builder: (context, container) {
                  filmsController.updateListFilms();
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
                              color:favoriteController.result[index].identificationCode.contains('p')? Color.fromRGBO(121, 168, 134,1):Color.fromARGB(153, 168, 82, 82),
                              child: ListTile(
                                trailing: IconButton(
                                  color: Color.fromRGBO(223, 31, 74, 0.6),
                                  icon: Icon(favoriteController.result[index].isSelected ? Icons.favorite : Icons.favorite_border),

                                  onPressed: () {

                                    int code=int.parse(favoriteController.result[index].identificationCode.substring(2));

                                    if (favoriteController.result[index].identificationCode.contains('p')) {
                                        peopleController.columnUpdateIsSelect(code,false);                                      
                                    } else if (favoriteController.result[index].identificationCode.contains('f')){
                                        filmsController.columnUpdateIsSelect(code, false);
                                    }
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
