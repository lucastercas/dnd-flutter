import 'package:dnd/blocs/character_bloc.dart';
import 'package:dnd/blocs/character_state.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterSavingThrows extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<CharacterFetchBloc>(context),
      builder: (context, state) {
        if (state is Fetched) {
          Character char = state.char;
          return Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  "Saving Throws",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 400,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: char.savingThrows.length,
                    itemBuilder: (BuildContext context, int index) {
                      var savingThrowName =
                          char.savingThrows.keys.elementAt(index);
                      Map<String, dynamic> curSavingThrow =
                          char.savingThrows[savingThrowName];
                      return Container(
                        child: Text(
                          "${curSavingThrow["value"]} $savingThrowName",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: curSavingThrow["proficient"]
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
        return Container();
      },
    );
  }
}
