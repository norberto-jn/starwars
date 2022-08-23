import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:fluttermoji/fluttermojiCustomizer.dart';
import 'package:starwars/pages/component/app_bar_layout.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarLayout(context, null),
        body: Column(
          children: [
            FluttermojiCircleAvatar(),
            FluttermojiCustomizer(),
          ],
        ));
  }
}
