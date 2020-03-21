import 'package:dnd/blocs/char_fetching_bloc.dart';
import 'package:dnd/blocs/character_state.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterPassivePerception extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<CharacterFetchBloc>(context),
      builder: (context, state) {
        if (state is Fetched) {
          Character char = state.char;
          return Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "${char.proficiencyBonus}",
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Text("Passive"),
                  Text("Perception"),
                ],
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
