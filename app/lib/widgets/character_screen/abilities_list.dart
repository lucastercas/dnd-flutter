import 'package:dnd/blocs/character/bloc.dart';
import 'package:dnd/blocs/character/state.dart';
import 'package:dnd/models/character.dart';
import 'package:dnd/widgets/character_screen/ability.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbilitiesList extends StatelessWidget {
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

  Widget _buildBody(Character character) {
    return Container(
      height: 108,
      padding: EdgeInsets.only(top: 8),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: character.abilities.length,
        itemBuilder: (BuildContext context, int index) {
          String abilityName = character.abilities.keys.elementAt(index);
          int curAbilityValue = character.abilities[abilityName];
          return Ability(
            value: curAbilityValue,
            name: abilityName,
            proficient: character.proficiencies.contains(abilityName),
          );
        },
      ),
    );
  }
}
