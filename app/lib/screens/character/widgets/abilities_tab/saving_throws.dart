import 'package:dnd/models/character.dart';
import 'package:dnd/screens/character/bloc/character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavingThrows extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: BlocProvider.of<CharacterBloc>(context),
      builder: (BuildContext context, CharacterState state) {
        if (state is Fetched)
          return _buildBody(state.character);
        // else if (state is Updated)
        //   return _buildBody(state.character);
        else
          return Container();
      },
    );
  }

  Expanded _buildBody(Character character) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            "Saving Throws",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Container(
            height: 400,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: character.savingThrows.length,
              itemBuilder: (BuildContext context, int index) {
                String savingThrowName = character.savingThrows.keys.elementAt(
                  index,
                );
                Map<dynamic, dynamic> savingThrow =
                    character.savingThrows[savingThrowName];
                return Container(
                  child: Text(
                    "${savingThrow["value"]} $savingThrowName",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: savingThrow["proficient"]
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
