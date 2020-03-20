import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/ability.dart';
import 'package:flutter/material.dart';

class AbilitiesTabView extends StatelessWidget {
  AbilitiesTabView({this.char});

  final Character char;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 8),
          height: 108,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: char.abilities.length,
            itemBuilder: (BuildContext context, int index) {
              String abilityName = char.abilities.keys.elementAt(index);
              var curAbility = char.abilities[abilityName];
              return AbilityWidget(
                mod: curAbility["mod"],
                value: curAbility["value"],
                name: abilityName,
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
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
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
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
            ),
            Row(
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
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text("Saving Throws"),
                ],
              ),
            ),
            Expanded(
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
            ),
          ],
        ),
      ],
    );
  }
}
