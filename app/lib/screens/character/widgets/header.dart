import 'package:dnd/models/character.dart';
import 'package:dnd/screens/character/bloc/character_bloc.dart';
import 'package:dnd/screens/character/widgets/armour.dart';
import 'package:dnd/screens/character/widgets/avatar.dart';
import 'package:dnd/screens/character/widgets/character_health.dart';
import 'package:dnd/screens/character/widgets/manage_character_health_buttons.dart';
import 'package:dnd/widgets/vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 14,
);

class CharacterInfoHeader extends StatelessWidget {
  final bool expanded;

  CharacterInfoHeader({this.expanded});

  Widget _buildNameLevel(Character character) {
    return Column(
      children: <Widget>[
        Text(character.name, style: _textStyle),
        Text("LV. ${character.level}", style: _textStyle),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: BlocProvider.of<CharacterBloc>(context),
      builder: (context, state) {
        var newState = state as Fetched;
        final Character character = newState.character;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  expanded ? Avatar() : Container(),
                  expanded ? _buildNameLevel(character) : Container(),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                expanded
                    ? Text(
                        "${character.race} ${character.charClass} - ${character.alignment}")
                    : SizedBox(),
                Divider(color: Colors.black, height: expanded ? 3 : 0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    expanded ? Container() : _buildNameLevel(character),
                    CharacterHealth(expanded: expanded),
                    MyVerticalDivider(),
                    Armour(armourValue: character.armour)
                  ],
                ),
                Divider(color: Colors.black, height: expanded ? 3 : 0),
                ManageHealthButtons(character: character),
              ],
            ),
          ],
        );
      },
    );
  }
}
