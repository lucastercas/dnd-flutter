import 'package:dnd/widgets/add_character_screen/ability_picker.dart';
import 'package:flutter/material.dart';

class AbilityForm extends StatelessWidget {
  final FocusNode _strFocus = FocusNode();
  final FocusNode _dexFocus = FocusNode();
  final FocusNode _conFocus = FocusNode();
  final FocusNode _intFocus = FocusNode();
  final FocusNode _wisFocus = FocusNode();
  final FocusNode _chaFocus = FocusNode();

  AbilityForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AbilityPicker(
          abilityName: "str",
          curFocus: _strFocus,
          nextFocus: _dexFocus,
        ),
        AbilityPicker(
          abilityName: "dex",
          curFocus: _dexFocus,
          nextFocus: _conFocus,
        ),
        AbilityPicker(
          abilityName: "con",
          curFocus: _conFocus,
          nextFocus: _intFocus,
        ),
        AbilityPicker(
          abilityName: "int",
          curFocus: _intFocus,
          nextFocus: _wisFocus,
        ),
        AbilityPicker(
          abilityName: "wis",
          curFocus: _wisFocus,
          nextFocus: _chaFocus,
        ),
        AbilityPicker(
          abilityName: "cha",
          curFocus: _chaFocus,
        ),
      ],
    );
  }
}
