import 'package:dnd/models/char.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ListCharacterState extends Equatable {}

class Initial extends ListCharacterState {
  @override
  List<Object> get props => [];
}

class Fetching extends ListCharacterState {
  @override
  List<Object> get props => [];
}

class Update extends ListCharacterState {
  final List<Character> characters;

  Update({@required this.characters});

  @override
  List<Object> get props => [characters];
}
