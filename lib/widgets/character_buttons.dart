import 'package:dnd/blocs/char_fetching_bloc.dart';
import 'package:dnd/blocs/character_event.dart';
import 'package:dnd/widgets/black_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ButtonsState {
  None,
  Damage,
  Heal,
  Temp,
}

TextStyle _btnTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 12,
  textBaseline: TextBaseline.alphabetic,
);

class HealthButton extends StatelessWidget {
  HealthButton({
    this.child,
    this.onPressed,
  });
  final Widget child;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: MaterialButton(
        height: 20,
        minWidth: 10,
        child: child,
        onPressed: onPressed,
        color: Colors.black,
      ),
    );
  }
}

class CharacterButtons extends StatefulWidget {
  @override
  _CharacterButtonsState createState() => _CharacterButtonsState();
}

class _CharacterButtonsState extends State<CharacterButtons> {
  ButtonsState state;

  @override
  void initState() {
    super.initState();
    state = ButtonsState.None;
  }

  List<Widget> _buildButtons(BuildContext context) {
    final charBloc = BlocProvider.of<CharacterFetchBloc>(context);
    switch (state) {
      case ButtonsState.None:
        return [
          BlackButton(
            text: "Damage",
            onPressed: () {
              setState(() {
                state = ButtonsState.Damage;
              });
            },
          ),
          BlackButton(
            text: "Heal",
            onPressed: () {},
          ),
          BlackButton(
            text: "Add Temp",
            onPressed: () {},
          ),
        ];
        break;
      case ButtonsState.Damage:
        return [
          HealthButton(
            child: Text("cancel", style: _btnTextStyle),
            onPressed: () {
              setState(() {
                state = ButtonsState.None;
              });
            },
          ),
          HealthButton(
            child: Text("idk", style: _btnTextStyle),
            onPressed: () {},
          ),
          HealthButton(
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 12,
            ),
            onPressed: () {
            },
          ),
          HealthButton(
            child: Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white,
              size: 12,
            ),
            onPressed: () {},
          ),
        ];
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ..._buildButtons(context),
      ],
    );
  }
}
