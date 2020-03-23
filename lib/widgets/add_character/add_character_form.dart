import 'package:dnd/blocs/add_character/bloc.dart';
import 'package:dnd/blocs/add_character/event.dart';
import 'package:dnd/blocs/add_character/state.dart';
import 'package:dnd/widgets/add_character/ability_picker.dart';
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
        print("State is: $state");
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
                    AbilityPicker(abilityName: "str"),
                    AbilityPicker(abilityName: "dex"),
                    AbilityPicker(abilityName: "con"),
                    AbilityPicker(abilityName: "wis"),
                    AbilityPicker(abilityName: "cha"),
                    AbilityPicker(abilityName: "int"),
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
          return CircularProgressIndicator();
        } else {
          return CircularProgressIndicator();
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
