import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/ability.dart';
import 'package:dnd/widgets/character_passive_perception.dart';
import 'package:dnd/widgets/character_proficiency_bonus.dart';
import 'package:dnd/widgets/character_saving_throws.dart';
import 'package:dnd/widgets/character_skills.dart';
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
          child: _buildAbilities(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CharacterProficiencyBonus(char: char),
            CharacterPassivePerception(char: char),
          ],
        ),
        Row(
          children: <Widget>[
            CharacterSavingThrows(char: char),
            CharacterSkills(char: char),
          ],
        ),
      ],
    );
  }

  ListView _buildAbilities() {
    return ListView.builder(
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
          proficient: char.proficiencies.contains(abilityName),
        );
      },
    );
  }
}
