import 'package:dnd/widgets/character_screen/abilities_list.dart';
import 'package:dnd/widgets/character_screen/passive_perception.dart';
import 'package:dnd/widgets/character_screen/proficiency_bonus.dart';
import 'package:dnd/widgets/character_screen/saving_throws.dart';
import 'package:dnd/widgets/character_screen/skills.dart';
import 'package:flutter/material.dart';

class AbilitiesTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AbilitiesList(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ProficiencyBonus(),
            PassivePerception(),
          ],
        ),
        Row(
          children: <Widget>[SavingThrows(), Skills()],
        ),
      ],
    );
  }
}
