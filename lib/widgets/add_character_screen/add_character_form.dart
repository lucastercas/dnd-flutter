import 'package:dnd/blocs/add_character/bloc.dart';
import 'package:dnd/blocs/add_character/event.dart';
import 'package:dnd/blocs/add_character/state.dart';
import 'package:dnd/services/storage.dart';
import 'package:dnd/widgets/add_character_screen/ability_form.dart';
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
  StorageProvider _storageProvider;
  String _choosenAvatar =
      "https://firebasestorage.googleapis.com/v0/b/dnd-flutter.appspot.com/o/avatars%2Fdefault.png?alt=media&token=b2cc8545-4a72-494d-a6f1-820961d3ab8c";

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _storageProvider = StorageProvider();
    _validate = false;
  }

  void _updateAvatar(String path) {
    setState(() {
      _choosenAvatar = path;
    });
    _addCharacterBloc.add(Update(key: 'avatar', value: _choosenAvatar));
  }

  @override
  Widget build(BuildContext context) {
    _addCharacterBloc = BlocProvider.of<AddCharacterBloc>(context);

    return BlocBuilder(
      bloc: _addCharacterBloc,
      builder: (BuildContext context, AddCharacterState state) {
        if (state is Initial || state is Updated)
          return _buildBody();
        else if (state is Finished)
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.pop(context),
          );
        return SizedBox.expand(child: CircularProgressIndicator());
      },
    );
  }

  Form _buildBody() {
    return Form(
      autovalidate: _validate,
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return FutureBuilder(
                        future: _storageProvider.getAvatars(),
                        builder: (
                          context,
                          AsyncSnapshot<Map<String, String>> snapshot,
                        ) {
                          return SelectAvatarDialog(
                            onPressed: _updateAvatar,
                            snapshot: snapshot,
                          );
                        },
                      );
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    _choosenAvatar,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Character Name'),
                ),
              ),
            ],
          ),
          AbilityForm(),
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
  }

  @override
  void dispose() {
    _addCharacterBloc.close();
    super.dispose();
  }
}

class SelectAvatarDialog extends StatefulWidget {
  final Function _onPressed;
  final AsyncSnapshot<Map<String, String>> snapshot;

  const SelectAvatarDialog(
      {Key key, @required Function onPressed, @required this.snapshot})
      : _onPressed = onPressed,
        super(key: key);

  @override
  _SelectAvatarDialogState createState() => _SelectAvatarDialogState();
}

class _SelectAvatarDialogState extends State<SelectAvatarDialog> {
  String _choosenAvatar = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select An Avatar"),
      content: widget.snapshot.hasData
          ? ListView.builder(
              itemCount: widget.snapshot.data.length,
              itemBuilder: (context, index) {
                String path = widget.snapshot.data.keys.elementAt(
                  index,
                );
                return MaterialButton(
                  onPressed: () {
                    setState(() {
                      _choosenAvatar = widget.snapshot.data[path];
                    });
                    widget._onPressed(_choosenAvatar);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.redAccent,
                          width: _choosenAvatar == widget.snapshot.data[path]
                              ? 4
                              : 0,
                        ),
                      ),
                      height: 100,
                      child: SizedBox.expand(
                        child: Image.network(
                          widget.snapshot.data[path],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : SizedBox.expand(
              child: CircularProgressIndicator(),
            ),
      actions: <Widget>[
        FlatButton(
          child: Text("Back"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
