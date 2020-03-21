import 'package:dnd/blocs/char_fetching_bloc.dart';
import 'package:dnd/blocs/character_state.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 14,
);

class CharacterLevelName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CharacterFetchBloc charBloc =
        BlocProvider.of<CharacterFetchBloc>(context);
    return BlocBuilder(
      bloc: charBloc,
      builder: (BuildContext context, CharacterState state) {
        if (state is Fetched) {
          final Character char = state.char;
          return Column(
            children: <Widget>[
              Text(char.name, style: _textStyle),
              Text("LV. ${char.level}", style: _textStyle),
            ],
          );
        }
        return Container();
      },
    );
  }
}
