import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/ability.dart';
import 'package:flutter/material.dart';

class BottomPart extends StatelessWidget {
  const BottomPart({Key key, @required this.char}) : super(key: key);

  final Character char;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildAbilities(),
          Container(
            height: 100,
            child: Row(
              children: <Widget>[
                Expanded(child: _buildSkills()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbilities() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: char.abilities.length,
        itemBuilder: (BuildContext context, int index) {
          String key = char.abilities.keys.elementAt(index);
          var curAbility = char.abilities[key];
          return AbilityWidget(
            mod: curAbility["mod"],
            value: curAbility["value"],
            name: key,
          );
        },
      ),
    );
  }

  Widget _buildSkills() {
    return ListView.builder(
      itemCount: char.skills.length,
      itemBuilder: (BuildContext context, int index) {
        return Text("${char.skills[index]} (Abi)");
      },
    );
  }
}
