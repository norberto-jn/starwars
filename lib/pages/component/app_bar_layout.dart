import 'package:flutter/material.dart';

class AppBarLayout extends AppBar {
  AppBarLayout(context, PreferredSizeWidget? bottom)
      : super(
            leading: IconButton(
              onPressed: (){
                Navigator.pushNamed(context, '/official');
              },
              icon: Icon(Icons.airplay_rounded)
            ),
            iconTheme: IconThemeData(size: 40),
            actions: [
              IconButton(
                color: Colors.white,
                icon: Icon(Icons.account_circle_outlined),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
                alignment: Alignment.center,
                tooltip: 'Perfil',
              )
            ],
            bottom: bottom
        );
}
