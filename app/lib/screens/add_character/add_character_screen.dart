import 'package:dnd/blocs/add_character/bloc.dart';
import 'package:dnd/blocs/character_repository.dart';
import 'package:dnd/widgets/add_character_screen/add_character_form.dart';
import 'package:dnd/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCharacterScreen extends StatefulWidget {
  final CharacterRepository charRepo;
  AddCharacterScreen({this.charRepo});
  @override
  _AddCharacterScreenState createState() => _AddCharacterScreenState();
}

class _AddCharacterScreenState extends State<AddCharacterScreen> {
  AddCharacterBloc _addCharBloc;

  @override
  void initState() {
    super.initState();
    _addCharBloc = AddCharacterBloc(charRepo: widget.charRepo);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _addCharBloc,
      child: Scaffold(
        appBar: MyAppBar(),
        backgroundColor: Color.fromRGBO(244, 235, 221, 1),
        body: AddCharacterForm(),
      ),
    );
  }

  @override
  void dispose() {
    // TO-DO: How to not reset form when this screen disposes?
    _addCharBloc.close();
    super.dispose();
  }
}
