import 'package:dnd/models/character.dart';
import 'package:dnd/screens/character/bloc/character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProficiencyBonus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: BlocProvider.of<CharacterBloc>(context),
      builder: (context, CharacterState state) {
        if (state is Fetched)
          return _buildBody(state.character);
        // else if (state is Updated)
        //   return _buildBody(state.character);
        else
          return Container();
      },
    );
  }

  Row _buildBody(Character character) {
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
              "${character.proficiencyBonus}",
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
}
