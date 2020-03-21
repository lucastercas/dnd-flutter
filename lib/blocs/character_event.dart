import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();
  @override
  List<Object> get props => [];
}

class CharacterSelectedEvent extends CharacterEvent {
  final String filePath;
  final String charName;

  CharacterSelectedEvent({
    @required this.filePath,
    @required this.charName,
  });
}

class CharacterUpdateEvent extends CharacterEvent {
  final Character char;
  CharacterUpdateEvent({@required this.char});
}
