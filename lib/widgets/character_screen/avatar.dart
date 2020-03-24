import 'package:dnd/blocs/character/bloc.dart';
import 'package:dnd/blocs/character/state.dart';
import 'package:dnd/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Avatar extends StatelessWidget {
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

  ClipRRect _buildBody(Character character) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 75,
        height: 90,
        // To-Do: Get avatar from firebase storage
        child: Image.asset(
          "assets/images/${character.avatar}.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
