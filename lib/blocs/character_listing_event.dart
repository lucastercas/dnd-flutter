import 'package:flutter/material.dart';

abstract class CharacterListingEvent {}

class CharacterSelectedEvent extends CharacterListingEvent {
  final String filePath;
  CharacterSelectedEvent({@required this.filePath});
}
