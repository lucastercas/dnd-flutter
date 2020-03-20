
import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';

class CharacterSkills extends StatelessWidget {
  const CharacterSkills({
    Key key,
    @required this.char,
  }) : super(key: key);

  final Character char;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text("Skill", style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            height: 400,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: char.skills.length,
              itemBuilder: (BuildContext context, int index) {
                String skillName = char.skills.keys.elementAt(index);
                Map<String, dynamic> curSkill = char.skills[skillName];
                return Container(
                  child: Text(
                    "${curSkill["value"]} $skillName (${curSkill['ability']})",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: curSkill["proficient"]
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
