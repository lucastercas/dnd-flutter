import 'package:dnd/blocs/repository.dart';
import 'package:dnd/screens/add_character.dart';
import 'package:dnd/screens/character.dart';
import 'package:dnd/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CharacterRepository _repo = CharacterRepository();
  runApp(MyApp(charRepo: _repo));
}

class MyApp extends StatelessWidget {
  final CharacterRepository charRepo;

  MyApp({this.charRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Cinzel',
        backgroundColor: Color.fromRGBO(244, 235, 221, 1),
      ),
      debugShowCheckedModeBanner: true,
      title: 'D&D App Mockup',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(charRepo: charRepo),
        '/character': (context) => CharacterScreen(charRepo: charRepo),
        '/add-character': (context) => AddCharacterScreen(charRepo: charRepo),
      },
    );
  }
}
