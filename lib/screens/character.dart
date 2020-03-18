import 'dart:convert';

import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class CharacterScreen extends StatefulWidget {
  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  Character parseJson(String data) {
    if (data == null) return null;
    Map charMap = jsonDecode(data);
    return Character.fromJson(charMap);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("assets/data.json"),
      builder: (context, snapshot) {
        Character char = parseJson(snapshot.data.toString());
        return Container(
          height: 180,
          child: Row(
            children: <Widget>[
              Container(
                width: 170,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  "assets/images/bard.jpg",
                  width: 170,
                  height: 150,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("${char.name} ${char.surname}"),
                  Text("${char.race} - ${char.charClass}"),
                  ProgressBar(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
