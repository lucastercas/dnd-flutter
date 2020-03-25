import 'package:dnd/models/character.dart';
import 'package:dnd/screens/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: BlocProvider.of<HomeBloc>(context),
      builder: (context, state) {
        if (state is Fetched) {
          Map<String, Character> characters = state.characters;
          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final String key = characters.keys.elementAt(index);
              return MaterialButton(
                elevation: 10,
                onPressed: () {
                  Navigator.pushNamed(context, '/character',
                      arguments: {'charId': key});
                },
                child: Row(
                  children: <Widget>[
                    ClipRRect(),
                    Text(characters[key].name),
                  ],
                ),
              );
            },
          );
        }
        return SizedBox.expand(child: CircularProgressIndicator());
      },
    );
  }
}
