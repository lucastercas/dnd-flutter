import 'package:dnd/blocs/character/state.dart';
import 'package:dnd/blocs/character/bloc.dart';
import 'package:dnd/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassivePerception extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<CharacterFetchBloc>(context),
      builder: (context, CharacterState state) {
        if (state is Fetched)
          return _buildBody(state.character);
        else if (state is Updated)
          return _buildBody(state.character);
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
            border: Border.all(width: 2)
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text("${character.proficiencyBonus}"),
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
}
