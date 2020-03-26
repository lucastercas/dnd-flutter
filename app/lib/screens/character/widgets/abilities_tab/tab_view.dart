import 'package:dnd/screens/character/widgets/abilities_tab/abilities_list.dart';
import 'package:dnd/screens/character/widgets/abilities_tab/passive_perception.dart';
import 'package:dnd/screens/character/widgets/abilities_tab/proficiency_bonus.dart';
import 'package:dnd/screens/character/widgets/abilities_tab/saving_throws.dart';
import 'package:dnd/screens/character/widgets/abilities_tab/skills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AbilitiesTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AbilitiesList(),
        SizedBox(
          height: ScreenUtil().setHeight(75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[ProficiencyBonus(), PassivePerception()],
          ),
        ),
        Row(
          children: <Widget>[SavingThrows(), Skills()],
        ),
      ],
    );
  }
}
