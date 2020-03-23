import 'package:dnd/blocs/character/bloc.dart';
import 'package:dnd/blocs/character/event.dart';
import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/black_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//To-Do: This file is ugly as fuck, fix this.
// How to separate the widgets?
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

class CharacterButtons extends StatefulWidget {
  final Character character;
  CharacterButtons({@required this.character});
  @override
  _CharacterButtonsState createState() => _CharacterButtonsState();
}

class _CharacterButtonsState extends State<CharacterButtons> {
  ButtonsState state;
  CharacterFetchBloc _charBloc;
  @override
  void initState() {
    super.initState();
    state = ButtonsState.None;
    _charBloc = BlocProvider.of<CharacterFetchBloc>(context);
  }

  List<Widget> _buildDefaultButtons() {
    return [
      BlackButton(
        child: Text("Damage", style: _btnTextStyle),
        onPressed: () {
          setState(() {
            state = ButtonsState.Damage;
          });
        },
      ),
      BlackButton(
        child: Text("Heal", style: _btnTextStyle),
        onPressed: () {
          setState(() {
            state = ButtonsState.Heal;
          });
        },
      ),
      BlackButton(
        child: Text("Add Temp", style: _btnTextStyle),
        onPressed: () {
          setState(() {
            state = ButtonsState.Temp;
          });
        },
      ),
    ];
  }

  List<Widget> _buildUpdateButtons({
    Function upButtonPress,
    Function downButtonPress,
  }) {
    return [
      BlackButton(
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 12,
        ),
        onPressed: () {
          setState(() {
            state = ButtonsState.None;
          });
        },
      ),
      // To-Do: Make this a text field, for easier input
      BlackButton(
        child: Text(
          "${widget.character.curHealth}",
          style: _btnTextStyle,
        ),
        onPressed: () {},
      ),
      BlackButton(
        child: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white,
          size: 12,
        ),
        onPressed: downButtonPress,
      ),
      BlackButton(
        child: Icon(
          Icons.keyboard_arrow_up,
          color: Colors.white,
          size: 12,
        ),
        onPressed: upButtonPress,
      ),
    ];
  }

  void _update(Map<String, dynamic> data) {
    this._charBloc.add(
          Update(
            characterName: widget.character.name,
            updateData: data,
          ),
        );
  }

  List<Widget> _buildButtons(BuildContext context) {
    switch (state) {
      case ButtonsState.Damage:
        return _buildUpdateButtons(
          upButtonPress: () {
            if (widget.character.curHealth < widget.character.maxHealth)
              _update({"curHealth": widget.character.curHealth + 1});
          },
          downButtonPress: () {
            if (widget.character.curHealth <= 0)
              // To-Do: Change to k.o status
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(title: Text("You Deead!"));
                  });
            else
              _update({"curHealth": widget.character.curHealth - 1});
          },
        );
        break;
      case ButtonsState.Heal:
        return _buildUpdateButtons(
          upButtonPress: () {
            _update({"healing": widget.character.healing + 1});
          },
          downButtonPress: () {
            if (widget.character.healing > 0)
              _update({"healing": widget.character.healing - 1});
          },
        );
        break;
      case ButtonsState.Temp:
        return _buildUpdateButtons(
          upButtonPress: () {
            _update({"tempHealth": widget.character.tempHealth + 1});
          },
          downButtonPress: () {
            if (widget.character.tempHealth > 0)
              _update({"tempHealth": widget.character.tempHealth - 1});
          },
        );
        break;
      case ButtonsState.None:
      default:
        return _buildDefaultButtons();
        break;
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
