import 'package:dnd/blocs/character_bloc.dart';
import 'package:dnd/blocs/character_state.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterProficiencyBonus extends StatelessWidget {
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
        return Container();
      },
    );
  }
}
