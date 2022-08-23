import 'package:flutter/material.dart';
import 'package:starwars/pages/home.dart';
import 'package:starwars/pages/official.dart';
import 'package:starwars/pages/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/official': (context) => OfficialPage()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
