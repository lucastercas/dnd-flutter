import 'package:dnd/blocs/character/bloc.dart';
import 'package:dnd/blocs/character/state.dart';
import 'package:dnd/models/character.dart';
import 'package:dnd/widgets/character_screen/linear_health_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterHealth extends StatelessWidget {
  final bool expanded;

  CharacterHealth({this.expanded});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<CharacterFetchBloc>(context),
      builder: (BuildContext context, CharacterState state) {
        if (state is Fetched)
          return _buildBody(state.character);
        else if (state is Updated)
          return _buildBody(state.character);
        else
          return Container();
      },
    );
  }

  Flexible _buildBody(Character character) {
    return Flexible(
      fit: FlexFit.loose,
      child: Column(
        children: <Widget>[
          Text(
            "${character.curHealth + character.healing + character.tempHealth} / ${character.maxHealth}",
            style: TextStyle(color: Colors.black),
          ),
          Container(
            width: 230,
            child: LinearHealthProgressIndicator(
              maxHealth: character.maxHealth,
              curHealth: character.curHealth,
              tempHealth: character.tempHealth,
              healing: character.healing,
            ),
          ),
        ],
      ),
    );
  }
}
