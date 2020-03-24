import 'package:dnd/models/character.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AddCharacterState extends Equatable {}

class Initial extends AddCharacterState {
  final Character character;
  Initial({@required this.character});
  @override
  List<Object> get props => [character];
}

class Updated extends AddCharacterState {
  final Character character;
  Updated({@required this.character});
  @override
  List<Object> get props => [character];
}

class Finished extends AddCharacterState {
  @override
  List<Object> get props => [];
}
