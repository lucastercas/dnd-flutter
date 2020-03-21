import 'package:flutter/material.dart';

abstract class CharacterFetchEvent {}

class CharacterSelectedEvent extends CharacterFetchEvent {
  final String filePath;
  final String charName;

  CharacterSelectedEvent({
    @required this.filePath,
    @required this.charName,
  });
}