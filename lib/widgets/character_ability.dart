import 'package:dnd/widgets/ability_mod.dart';
import 'package:dnd/widgets/ability_value.dart';
import 'package:flutter/material.dart';

class AbilityWidget extends StatelessWidget {
  const AbilityWidget({
    Key key,
    @required this.name,
    @required this.value,
    @required this.mod,
    @required this.proficient,
  }) : super(key: key);

  final String name;
  final int value;
  final int mod;
  final bool proficient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4, right: 4),
      child: Stack(
        children: <Widget>[
          ModAbility(name: name, mod: mod, proficient: proficient),
          ValueAbility(value: value)
        ],
      ),
    );
  }
}
