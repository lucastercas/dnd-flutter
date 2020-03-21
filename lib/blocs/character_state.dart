import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';

abstract class CharacterState {}

class CharacterUninitializedState extends CharacterState {}

class CharacterFetchingState extends CharacterState {}

class CharacterFetchedState extends CharacterState {
  final Character char;
  CharacterFetchedState({@required this.char});
}

class CharacterErrorState extends CharacterState {}

class CharacterEmptyState extends CharacterState {}
