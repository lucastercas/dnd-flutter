import 'package:dnd/blocs/character/bloc.dart';
import 'package:dnd/blocs/character/state.dart';
import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/character_armour.dart';
import 'package:dnd/widgets/character_avatar.dart';
import 'package:dnd/widgets/character_health_buttons.dart';
import 'package:dnd/widgets/character_health.dart';
import 'package:dnd/widgets/character_name_level.dart';
import 'package:dnd/widgets/vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterStatus extends StatelessWidget {
  final bool expanded;

  CharacterStatus({this.expanded});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<CharacterFetchBloc>(context),
      builder: (BuildContext context, CharacterState state) {
        var newState = state as Fetched;
        final Character char = newState.character;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  expanded ? CharacterAvatar() : Container(),
                  expanded ? CharacterLevelName() : Container(),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                expanded
                    ? Text(
                        "${char.race} ${char.charClass} - ${char.alignment}",
                      )
                    : SizedBox(),
                Divider(color: Colors.black, height: expanded ? 3 : 0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    expanded ? Container() : CharacterLevelName(),
                    CharacterHealth(expanded: expanded),
                    MyVerticalDivider(),
                    Armour(armourValue: char.armour)
                  ],
                ),
                Divider(color: Colors.black, height: expanded ? 3 : 0),
                CharacterButtons(character: char),
              ],
            ),
          ],
        );
      },
    );
  }
}
