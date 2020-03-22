import 'package:dnd/blocs/character_bloc.dart';
import 'package:dnd/blocs/character_bloc.dart';
import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/character_ability.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterAbilitiesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<CharacterFetchBloc>(context),
      builder: (context, state) {
        if (state is Fetched) {
          Character char = state.char;
          return Container(
            height: 108,
            padding: EdgeInsets.only(top: 8),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: char.abilities.length,
              itemBuilder: (BuildContext context, int index) {
                String abilityName = char.abilities.keys.elementAt(index);
                var curAbility = char.abilities[abilityName];
                return AbilityWidget(
                  value: curAbility,
                  name: abilityName,
                  proficient: char.proficiencies.contains(abilityName),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
