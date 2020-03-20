import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';

class CharacterSavingThrows extends StatelessWidget {
  const CharacterSavingThrows({
    Key key,
    @required this.char,
  }) : super(key: key);
  final Character char;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            "Saving Throws",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Container(
            height: 400,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: char.savingThrows.length,
              itemBuilder: (BuildContext context, int index) {
                var savingThrowName = char.savingThrows.keys.elementAt(index);
                Map<String, dynamic> curSavingThrow =
                    char.savingThrows[savingThrowName];
                return Container(
                  child: Text(
                    "${curSavingThrow["value"]} ${savingThrowName}",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: curSavingThrow["proficient"]
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
