import 'package:dnd/blocs/char_bloc.dart';
import 'package:dnd/blocs/player_state.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 14,
);

class CharacterLevelName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CharacterListingBloc charBloc =
        BlocProvider.of<CharacterListingBloc>(context);
    return BlocBuilder(
      bloc: charBloc,
      builder: (BuildContext context, CharacterListingState state) {
        if (state is CharacterFetchedState) {
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
