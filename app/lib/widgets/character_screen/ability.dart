import 'package:dnd/screens/character/widgets/abilities_tab/ability_mod.dart';
import 'package:dnd/screens/character/widgets/abilities_tab/ability_value.dart';
import 'package:flutter/material.dart';

class Ability extends StatelessWidget {
  final String name;
  final int value;
  final bool proficient;

  const Ability({
    Key key,
    @required this.name,
    @required this.value,
    @required this.proficient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4, right: 4),
      child: Stack(
        children: <Widget>[
          AbilityModifier(name: name, value: value, proficient: proficient),
          AbilityValue(value: value)
        ],
      ),
    );
  }
}
