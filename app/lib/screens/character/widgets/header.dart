import 'package:dnd/models/character.dart';
import 'package:dnd/screens/character/bloc/character_bloc.dart';
import 'package:dnd/screens/character/widgets/armour.dart';
import 'package:dnd/screens/character/widgets/avatar.dart';
import 'package:dnd/screens/character/widgets/character_health.dart';
import 'package:dnd/screens/character/widgets/manage_character_health_buttons.dart';
import 'package:dnd/widgets/vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

TextStyle _textStyle = TextStyle(
  fontSize: ScreenUtil().setSp(22),
);

class CharacterInfoHeader extends StatelessWidget {
  final bool expanded;

  CharacterInfoHeader({this.expanded});

  Widget _buildTop(Character character) {
    return expanded
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Avatar(),
              Column(
                children: <Widget>[
                  Text(
                    "${character.name}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(35),
                    ),
                  ),
                  Text(
                      "LV. ${character.level} ${character.race} ${character.charClass} - ${character.alignment}"),
                ],
              )
            ],
          )
        : Text(
            "${character.name} - LV. ${character.level} ${character.race} ${character.charClass} - ${character.alignment}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: BlocProvider.of<CharacterBloc>(context),
      builder: (context, state) {
        var newState = state as Updated;
        final Character character = newState.character;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTop(character),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CharacterHealth(expanded: expanded),
                MyVerticalDivider(),
                Armour(armourValue: character.armour)
              ],
            ),
            Divider(color: Colors.black, height: expanded ? 3 : 0),
            ManageHealthButtons(character: character),
          ],
        );
      },
    );
  }
}
