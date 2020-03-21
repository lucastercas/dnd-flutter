import 'package:flutter/material.dart';

abstract class CharacterEvent {}

class CharacterSelectedEvent extends CharacterEvent {
  final String filePath;
  final String charName;
  CharacterSelectedEvent({
    @required this.filePath,
    @required this.charName,
  });
}
