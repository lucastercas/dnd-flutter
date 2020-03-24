import 'package:dnd/blocs/character/bloc.dart';
import 'package:dnd/blocs/character/event.dart';
import 'package:dnd/models/character.dart';
import 'package:dnd/widgets/black_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//To-Do: This file is ugly as fuck, fix this.
// How to separate the widgets?
enum ButtonsState {
  Default,
  Damage,
  Heal,
  Temp,
}

TextStyle _btnTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 12,
  textBaseline: TextBaseline.alphabetic,
);

class ManageHealthButtons extends StatefulWidget {
  final Character character;
  ManageHealthButtons({@required this.character});
  @override
  _CharacterButtonsState createState() => _CharacterButtonsState();
}

class _CharacterButtonsState extends State<ManageHealthButtons> {
  ButtonsState _state;
  CharacterFetchBloc _charBloc;

  @override
  void initState() {
    super.initState();
    _state = ButtonsState.Default;
    _charBloc = BlocProvider.of<CharacterFetchBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[..._buildButtons(context)],
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    switch (_state) {
      case ButtonsState.Damage:
        return _buildUpdateButtons(
          text: widget.character.curHealth.toString(),
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
          text: widget.character.healing.toString(),
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
          text: widget.character.tempHealth.toString(),
          upButtonPress: () {
            _update({"tempHealth": widget.character.tempHealth + 1});
          },
          downButtonPress: () {
            if (widget.character.tempHealth > 0)
              _update({"tempHealth": widget.character.tempHealth - 1});
          },
        );
        break;
      case ButtonsState.Default:
      default:
        return _buildDefaultButtons();
        break;
    }
  }

  List<Widget> _buildDefaultButtons() {
    return [
      BlackButton(
        child: Text("Damage", style: _btnTextStyle),
        onPressed: () {
          setState(() {
            _state = ButtonsState.Damage;
          });
        },
      ),
      BlackButton(
        child: Text("Heal", style: _btnTextStyle),
        onPressed: () {
          setState(() {
            _state = ButtonsState.Heal;
          });
        },
      ),
      BlackButton(
        child: Text("Add Temp", style: _btnTextStyle),
        onPressed: () {
          setState(() {
            _state = ButtonsState.Temp;
          });
        },
      ),
    ];
  }

  List<Widget> _buildUpdateButtons({
    @required String text,
    @required Function upButtonPress,
    @required Function downButtonPress,
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
            _state = ButtonsState.Default;
          });
        },
      ),
      BlackButton(
        // To-Do: Make this btn a text field, for easier input
        child: Text(text, style: _btnTextStyle),
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
          Update(characterName: widget.character.name, updateData: data),
        );
  }
}
