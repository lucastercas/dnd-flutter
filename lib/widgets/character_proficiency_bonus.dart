import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';

class CharacterProficiencyBonus extends StatelessWidget {
  const CharacterProficiencyBonus({
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
            padding: EdgeInsets.all(12),
            child: Text(
              "${char.proficiencyBonus}",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Text("Proficiency"),
            Text("Bonus"),
          ],
        ),
      ],
    );
  }
}