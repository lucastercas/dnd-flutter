import 'package:dnd/blocs/char_bloc.dart';
import 'package:dnd/blocs/player_state.dart';
import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/health_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterHealth extends StatelessWidget {
  final bool expanded;

  CharacterHealth({this.expanded});

  @override
  Widget build(BuildContext context) {
    final CharacterListingBloc charBloc =
        BlocProvider.of<CharacterListingBloc>(context);
    return BlocBuilder(
      bloc: charBloc,
      builder: (BuildContext context, CharacterListingState state) {
        if (state is CharacterFetchedState) {
          final Character char = state.char;
          return Flexible(
            fit: FlexFit.loose,
            child: Column(
              children: <Widget>[
                Text(
                  "${char.curHealth + char.healing + char.tempHealth} / ${char.maxHealth}",
                  style: TextStyle(color: Colors.black),
                ),
                Container(
                  width: 230,
                  child: LinearHealthProgressIndicator(
                    maxHealth: char.maxHealth,
                    curHealth: char.curHealth,
                    tempHealth: char.tempHealth,
                    healing: char.healing,
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
