import 'package:dnd/blocs/add_character/bloc.dart';
import 'package:dnd/blocs/add_character/event.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCharacterScreen extends StatefulWidget {
  final CharacterRepository charRepo;
  AddCharacterScreen({this.charRepo});
  @override
  _AddCharacterScreenState createState() => _AddCharacterScreenState();
}

class _AddCharacterScreenState extends State<AddCharacterScreen> {
  var _formKey;
  bool _validate;
  CharacterAddBloc _addCharBloc;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _validate = false;
    _addCharBloc = CharacterAddBloc(charRepo: widget.charRepo);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _addCharBloc,
      child: Scaffold(
        appBar: MyAppBar(),
        backgroundColor: Color.fromRGBO(244, 235, 221, 1),
        body: AddCharacterForm(validate: _validate, formKey: _formKey),
      ),
    );
  }

  @override
  void dispose() {
    _addCharBloc.close();
    super.dispose();
  }
}

class AddCharacterForm extends StatelessWidget {
  const AddCharacterForm({
    Key key,
    @required bool validate,
    @required formKey,
  })  : _validate = validate,
        _formKey = formKey,
        super(key: key);

  final bool _validate;
  final _formKey;

  @override
  Widget build(BuildContext context) {
    CharacterAddBloc addCharBloc = BlocProvider.of<CharacterAddBloc>(context);
    return Form(
      autovalidate: _validate,
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
              decoration: InputDecoration(hintText: 'Character Name')),
          Column(
            children: <Widget>[
              AbilityChooser(text: "str"),
              AbilityChooser(text: "dex"),
              AbilityChooser(text: "con"),
              AbilityChooser(text: "wis"),
              AbilityChooser(text: "cha"),
              AbilityChooser(text: "int"),
            ],
          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) addCharBloc.add(Finish());
            },
            child: Text("Finish"),
          ),
        ],
      ),
    );
  }
}

class AbilityChooser extends StatefulWidget {
  final String text;
  const AbilityChooser({
    @required this.text,
    Key key,
  }) : super(key: key);
  @override
  _AbilityChooserState createState() => _AbilityChooserState();
}

class _AbilityChooserState extends State<AbilityChooser> {
  final controller = TextEditingController(text: "1");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<CharacterAddBloc>(context),
      builder: (context, state) {
        return SizedBox(
          height: 30,
          child: Row(
            children: <Widget>[
              SizedBox(width: 35, child: Text(widget.text)),
              UpButton(controller: controller, ability: widget.text),
              Container(
                width: 30,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(),
                  keyboardType: TextInputType.number,
                  controller: controller,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  validator: (String text) {
                    int value = int.parse(text);
                    // To-Do: Show warning message
                    if (value < 0 || value > 30) print("ERROR: On");
                    return null;
                  },
                ),
              ),
              DownButton(controller: controller, ability: widget.text),
            ],
          ),
        );
      },
    );
  }
}

class UpButton extends StatelessWidget {
  final TextEditingController controller;
  final String ability;

  UpButton({@required this.controller, @required this.ability});

  @override
  Widget build(BuildContext context) {
    CharacterAddBloc addCharBloc = BlocProvider.of<CharacterAddBloc>(context);
    return MaterialButton(
      padding: EdgeInsets.all(0),
      height: 25,
      minWidth: 20,
      child: Icon(
        Icons.keyboard_arrow_up,
        color: Colors.white,
      ),
      onPressed: () {
        int value = int.parse(controller.text);
        if (value < 30) {
          value++;
          controller.text = value.toString();
          addCharBloc.add(Update(ability: this.ability, value: value));
        }
      },
      color: Colors.black,
    );
  }
}

class DownButton extends StatelessWidget {
  final TextEditingController controller;
  final String ability;

  DownButton({@required this.controller, @required this.ability});

  @override
  Widget build(BuildContext context) {
    CharacterAddBloc addCharBloc = BlocProvider.of<CharacterAddBloc>(context);
    return MaterialButton(
      padding: EdgeInsets.all(0),
      height: 25,
      minWidth: 10,
      child: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      onPressed: () {
        int value = int.parse(controller.text);
        if (value > 1) {
          value--;
          controller.text = value.toString();
          addCharBloc.add(Update(ability: this.ability, value: value));
        }
      },
      color: Colors.black,
    );
  }
}
