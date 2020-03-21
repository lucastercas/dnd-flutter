import 'package:dnd/widgets/black_button.dart';
import 'package:flutter/material.dart';

class CharacterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        BlackButton(text: "Damage"),
        BlackButton(text: "Heal"),
        BlackButton(text: "Add Temp"),
      ],
    );
  }
}