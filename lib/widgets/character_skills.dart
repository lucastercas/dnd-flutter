import 'package:dnd/blocs/character/bloc.dart';
import 'package:dnd/blocs/character/state.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterSkills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<CharacterFetchBloc>(context),
      builder: (context, CharacterState state) {
        if (state is Fetched) {
          Character char = state.character;
          return Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  "Skills",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 400,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: char.skills.length,
                    itemBuilder: (BuildContext context, int index) {
                      String skillName = char.skills.keys.elementAt(index);
                      Map<dynamic, dynamic> curSkill = char.skills[skillName];
                      return Container(
                        child: Text(
                          "${curSkill["value"]} $skillName (${curSkill['ability']})",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: curSkill["proficient"]
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
