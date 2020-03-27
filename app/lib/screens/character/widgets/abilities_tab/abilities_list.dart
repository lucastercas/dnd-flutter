import 'package:dnd/models/character.dart';
import 'package:dnd/screens/character/bloc/character_bloc.dart';
import 'package:dnd/screens/character/widgets/abilities_tab/ability.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

class AbilitiesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: BlocProvider.of<CharacterBloc>(context),
      builder: (context, state) {
        if (state is Updated) return _buildBody(state.character);
        return Container();
      },
    );
  }

  Widget _buildBody(Character character) {
    return Container(
      height: ScreenUtil().setHeight(220),
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
