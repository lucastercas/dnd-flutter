import 'package:dnd/models/char.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CharacterAddState extends Equatable {}

class Initial extends CharacterAddState {
  final Character character;
  Initial({@required this.character});
  @override
  List<Object> get props => [character];
}

class Updated extends CharacterAddState {
  final Character character;
  Updated({@required this.character});
  @override
  List<Object> get props => [character];
}

class Finished extends CharacterAddState {
  @override
  List<Object> get props => [];
}
