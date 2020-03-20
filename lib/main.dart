import 'package:dnd/screens/character.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Cinzel'),
      title: 'D&D App Mockup',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(244, 235, 221, 1000),
          title: Center(
            child: Text(
              "D&D App Mockup",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: CharacterScreen(),
      ),
    );
  }
}
