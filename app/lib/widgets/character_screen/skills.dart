import 'package:dnd/blocs/character/bloc.dart';
import 'package:dnd/blocs/character/state.dart';
import 'package:dnd/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Skills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<CharacterFetchBloc>(context),
      builder: (BuildContext context, CharacterState state) {
        if (state is Fetched) return _buildBody(state.character);
        if (state is Updated) return _buildBody(state.character);
        return Container();
      },
    );
  }

  Expanded _buildBody(Character character) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            "Skills",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Container(
            height: 400,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: character.skills.length,
              itemBuilder: (BuildContext context, int index) {
                String skillName = character.skills.keys.elementAt(index);
                Map<dynamic, dynamic> skill = character.skills[skillName];
                return Container(
                  child: Text(
                    "${skill["value"]} $skillName (${skill['ability']})",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: skill["proficient"]
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
}
