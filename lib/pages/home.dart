import 'package:flutter/material.dart';

import 'package:starwars/modules/favorites/src/favorites_controller.dart';
import 'package:starwars/modules/favorites/src/models/favorites_entity.dart';
import 'package:starwars/modules/films/src/dto/film_response.dart';
import 'package:starwars/modules/films/src/films_controller.dart';
import 'package:starwars/modules/films/src/services/films_manager.dart';
import 'package:starwars/modules/people/src/dto/people.dart';
import 'package:starwars/modules/people/src/people_controller.dart';
import 'package:starwars/modules/people/src/services/people_manager.dart';
import 'package:starwars/pages/component/app_bar_layout.dart';
import 'package:starwars/pages/component/favorite_layout.dart';
import 'package:starwars/pages/component/film_layout.dart';
import 'package:starwars/pages/component/people_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final favoriteController = FavoriteController();
  final peopleController = PeopleController();
  final filmsController = FilmsController();

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
          'push'
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
                  return FilmLayout.getContainer(filmsController,favoriteController);
                }
            ),
            //---------------------------------------
            //------------ Personagens --------------
            //---------------------------------------
            AnimatedBuilder(
                animation: peopleController,
                builder: (context, container) {
                  peopleController.updateListPeoples();
                  return PeopleLayout.getContainer(peopleController, favoriteController);
                }
            ),            
            //---------------------------------------
            //------------- Favoritos ---------------
            //---------------------------------------
            AnimatedBuilder(
                animation: favoriteController,
                builder: (context, container) {
                  return FavoriteLayout.getContainer(favoriteController, peopleController, filmsController);
                }
            )
          ],
        ),
      ),
    );
  }
}