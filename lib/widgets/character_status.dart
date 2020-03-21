import 'package:dnd/blocs/char_bloc.dart';
import 'package:dnd/blocs/player_state.dart';
import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/character_armour.dart';
import 'package:dnd/widgets/character_avatar.dart';
import 'package:dnd/widgets/character_buttons.dart';
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
    final CharacterListingBloc charBloc =
        BlocProvider.of<CharacterListingBloc>(context);
    return BlocBuilder(
      bloc: charBloc,
      builder: (BuildContext context, CharacterListingState state) {
        if (state is CharacterUninitializedState ||
            state is CharacterFetchingState) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CharacterEmptyState) {
          return Container(child: Text("Empty"));
        } else if (state is CharacterErrorState) {
          return Container(child: Text("Error"));
        } else {
          final fetchedState = state as CharacterFetchedState;
          final Character char = fetchedState.char;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Avatar, name and lvl part
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
                      : Container(),
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
                  CharacterButtons(),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
