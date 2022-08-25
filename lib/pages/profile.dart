import 'dart:math';

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
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBarLayout(context, null,'pop'),
        body: Column(
          children: [
            FluttermojiCircleAvatar(),
            SizedBox(
                width: min(600, _width * 0.85),
                child: Row(
                  children: [
                    Text(
                      "Customize:",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Spacer(),
                    //FluttermojiSaveWidget(),
                  ],
                ),
            ),
            FluttermojiCustomizer(),
          ],
        ));
  }
}
