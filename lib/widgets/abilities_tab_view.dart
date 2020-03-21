import 'package:dnd/widgets/character_abilities_list.dart';
import 'package:dnd/widgets/character_passive_perception.dart';
import 'package:dnd/widgets/character_proficiency_bonus.dart';
import 'package:dnd/widgets/character_saving_throws.dart';
import 'package:dnd/widgets/character_skills.dart';
import 'package:flutter/material.dart';

class AbilitiesTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CharacterAbilitiesList(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CharacterProficiencyBonus(),
            CharacterPassivePerception(),
          ],
        ),
        Row(
          children: <Widget>[
            CharacterSavingThrows(),
            CharacterSkills(),
          ],
        ),
      ],
    );
  }
}
