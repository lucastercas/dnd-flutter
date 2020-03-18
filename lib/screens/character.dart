import 'dart:convert';

import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/char_btn.dart';
import 'package:dnd/widgets/health_bar.dart';
import 'package:flutter/material.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 15,
);

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
        return Row(
          children: <Widget>[
            buildAvatar(name: char.name),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${char.race} - ${char.charClass}",
                    style: _textStyle,
                  ),
                  Divider(),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 17,
                          child: LinearHealthProgressIndicator(
                            maxHealth: char.maxHealth,
                            curHealth: char.curHealth,
                            healing: 4,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.grey,
                          height: 25,
                          width: 1,
                        ),
                      ),
                      Text("${char.curHealth}", style: TextStyle(fontSize: 20)),
                      Text(
                        " + ${4}",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                      Text(" / ${char.maxHealth}", style: TextStyle(fontSize: 20))
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CharButton(
                        text: "Damage",
                      ),
                      CharButton(
                        text: "Heal",
                      ),
                      CharButton(
                        text: "Add Temporary",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Padding buildAvatar({String name}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              "assets/images/bard.jpg",
              width: 150,
              height: 150,
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontFamily: 'Cinzel',
            ),
          ),
        ],
      ),
    );
  }
}
