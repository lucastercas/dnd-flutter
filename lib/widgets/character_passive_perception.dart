import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';

class CharacterPassivePerception extends StatelessWidget {
  const CharacterPassivePerception({
    Key key,
    @required this.char,
  }) : super(key: key);

  final Character char;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "${char.proficiencyBonus}",
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Text("Passive"),
            Text("Perception"),
          ],
        ),
      ],
    );
  }
}