import 'package:dnd/blocs/character/bloc.dart';
import 'package:dnd/blocs/character/state.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final charBloc = BlocProvider.of<CharacterFetchBloc>(
      context,
    );
    return BlocBuilder(
      bloc: charBloc,
      builder: (BuildContext context, CharacterState state) {
        if (state is Fetched) {
          final Character char = state.character;
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
