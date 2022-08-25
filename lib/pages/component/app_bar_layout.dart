import 'package:flutter/material.dart';

class AppBarLayout extends AppBar {
  AppBarLayout(context, PreferredSizeWidget? bottom,String typeRoute)
      : super(
            leading: TextButton(
               onPressed: (){
                if (typeRoute == 'push') {
                  Navigator.pushNamed(context, '/official');                  
                }else{
                  Navigator.pop(context, '/');   
                }
              },
              child: Text("Site Oficial",style: TextStyle(color: Colors.white),)
            ),
            iconTheme: IconThemeData(size: 40),
            actions: [
              IconButton(
                color: Colors.white,
                icon: Icon(Icons.account_circle_outlined),
                onPressed: () {
                  if (typeRoute == 'push') {
                  Navigator.pushNamed(context, '/profile');                  
                }else{
                  Navigator.pop(context, '/');   
                }
                },
                alignment: Alignment.center,
                tooltip: 'Perfil',
              )
            ],
            bottom: bottom
        );
}
