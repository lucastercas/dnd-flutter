import 'package:dnd/blocs/char_bloc.dart';
import 'package:dnd/blocs/player_state.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterProficiencyBonus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<CharacterListingBloc>(context),
      builder: (context, state) {
        if (state is CharacterFetchedState) {
          Character char = state.char;
          return Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "${char.proficiencyBonus}",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Text("Proficiency"),
                  Text("Bonus"),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
