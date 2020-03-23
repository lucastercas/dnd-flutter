import 'package:dnd/blocs/add_character/bloc.dart';
import 'package:dnd/blocs/add_character/event.dart';
import 'package:dnd/widgets/add_character/arrow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbilityPicker extends StatefulWidget {
  final String abilityName;

  AbilityPicker({@required this.abilityName});
  @override
  _AbilityPickerState createState() => _AbilityPickerState();
}

class _AbilityPickerState extends State<AbilityPicker> {
  TextEditingController _controller;
  AddCharacterBloc _addCharacterBloc;

  @override
  void initState() {
    super.initState();
    this._controller = TextEditingController(text: "1");
  }

  @override
  Widget build(BuildContext context) {
    _addCharacterBloc = BlocProvider.of<AddCharacterBloc>(context);
    return SizedBox(
      height: 30,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 35,
            child: Text(widget.abilityName),
          ),
          ArrowButton(
            child: Icon(Icons.keyboard_arrow_up, color: Colors.white),
            onPressed: () {
              int value = int.parse(_controller.text);
              if (value < 30) {
                value++;
                _controller.text = value.toString();
                _addCharacterBloc.add(
                  Update(ability: widget.abilityName, value: value),
                );
              }
            },
          ),
          SizedBox(
            height: 35,
            width: 35,
            child: TextFormField(
              controller: this._controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
          ArrowButton(
            child: Icon(Icons.keyboard_arrow_down, color: Colors.white),
            onPressed: () {
              int value = int.parse(_controller.text);
              if (value > 1) {
                value--;
                _controller.text = value.toString();
                _addCharacterBloc.add(
                  Update(ability: widget.abilityName, value: value),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
