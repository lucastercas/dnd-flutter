import 'package:dnd/models/character.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CharacterState extends Equatable {}

class Initial extends CharacterState {
  @override
  List<Object> get props => [];
}

class Fetched extends CharacterState {
  final Character character;
  Fetched({@required this.character});
  @override
  List<Object> get props => [character];
}

class Updated extends CharacterState {
  final Character character;
  Updated({@required this.character});
  @override
  List<Object> get props => [character];
}
