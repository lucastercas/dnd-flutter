import 'dart:convert';

import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/char_bottom_part.dart';
import 'package:dnd/widgets/char_top_part.dart';
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
        if (snapshot.hasError) return Container();
        var data = snapshot.data;
        Character char = parseJson(data);

        return char == null
            ? Container(child: Text("NULL"))
            : Column(
                children: <Widget>[
                  Expanded(child: TopPart(char: char), flex: 2),
                  Divider(color: Colors.black),
                  Expanded(child: BottomPart(char: char), flex: 7),
                ],
              );
      },
    );
  }
}
