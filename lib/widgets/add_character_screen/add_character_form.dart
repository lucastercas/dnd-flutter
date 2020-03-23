import 'package:dnd/blocs/add_character/bloc.dart';
import 'package:dnd/blocs/add_character/event.dart';
import 'package:dnd/blocs/add_character/state.dart';
import 'package:dnd/widgets/add_character_screen/ability_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCharacterForm extends StatefulWidget {
  const AddCharacterForm({Key key}) : super(key: key);

  @override
  _AddCharacterFormState createState() => _AddCharacterFormState();
}

class _AddCharacterFormState extends State<AddCharacterForm> {
  var _formKey;
  bool _validate;
  AddCharacterBloc _addCharacterBloc;

  final FocusNode _strFocus = FocusNode();
  final FocusNode _dexFocus = FocusNode();
  final FocusNode _conFocus = FocusNode();
  final FocusNode _intFocus = FocusNode();
  final FocusNode _wisFocus = FocusNode();
  final FocusNode _chaFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _validate = false;
  }

  @override
  Widget build(BuildContext context) {
    _addCharacterBloc = BlocProvider.of<AddCharacterBloc>(context);

    return BlocBuilder(
      bloc: _addCharacterBloc,
      builder: (BuildContext context, AddCharacterState state) {
        if (state is Initial || state is Updated) {
          return Form(
            autovalidate: _validate,
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(hintText: 'Character Name'),
                ),
                Column(
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
                      nextFocus: _wisFocus
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
                ),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate())
                      _addCharacterBloc.add(Finish());
                  },
                  child: Text("Finish"),
                ),
              ],
            ),
          );
        } else if (state is Finished) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.pop(context),
          );
          return SizedBox.expand(child: CircularProgressIndicator());
        } else {
          return SizedBox.expand(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _addCharacterBloc.close();
    super.dispose();
  }
}
