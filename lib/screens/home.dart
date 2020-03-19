import 'package:dnd/screens/character.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 235, 221, 9),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 235, 221, 1000),
        title: Text("DnD App MockUp", style: TextStyle(color: Colors.black, fontFamily: "Cinzel")),
      ),
      body: CharacterScreen(),
    );
  }
}
