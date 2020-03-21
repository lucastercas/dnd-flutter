import 'package:dnd/blocs/char_bloc.dart';
import 'package:dnd/blocs/character_state.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final charBloc = BlocProvider.of<CharacterBloc>(
      context,
    );
    return BlocBuilder(
      bloc: charBloc,
      builder: (BuildContext context, CharacterState state) {
        if (state is CharacterFetchedState) {
          final Character char = state.char;
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 75,
              height: 90,
              child: Image.asset(
                "assets/images/${char.avatar}.jpg",
                fit: BoxFit.cover,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
