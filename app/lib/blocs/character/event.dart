import 'package:dnd/blocs/add_character/event.dart';
import 'package:dnd/models/character.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CharacterEvent extends Equatable {}

class Select extends CharacterEvent {
  final String characterName;
  Select({@required this.characterName});
  @override
  List<Object> get props => [characterName];
}

class Fetch extends CharacterEvent {
  final Character character;
  Fetch({@required this.character});
  @override
  List<Object> get props => [character];
}

class Update extends CharacterEvent {
  final String characterName;
  final Map<String, dynamic> updateData;
  Update({
    @required this.characterName,
    @required this.updateData,
  });
  @override
  List<Object> get props => [characterName, updateData];
}

class Finish extends AddCharacterEvent {
  @override
  List<Object> get props => [];
}
