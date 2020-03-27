import 'package:dnd/models/character.dart';
import 'package:dnd/screens/character/bloc/character_bloc.dart';
import 'package:dnd/screens/character/widgets/linear_health_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CharacterHealth extends StatelessWidget {
  final bool expanded;

  CharacterHealth({this.expanded});

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

  Flexible _buildBody(Character character) {
    return Flexible(
      fit: FlexFit.loose,
      child: Column(
        children: <Widget>[
          Text(
            "${character.curHealth + character.healing + character.tempHealth} / ${character.maxHealth}",
            style: TextStyle(color: Colors.black),
          ),
          Container(
            width: ScreenUtil().setWidth(600),
            child: LinearHealthProgressIndicator(
              maxHealth: character.maxHealth,
              curHealth: character.curHealth,
              tempHealth: character.tempHealth,
              healing: character.healing,
            ),
          ),
        ],
      ),
    );
  }
}
