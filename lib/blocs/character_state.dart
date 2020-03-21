import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';

abstract class CharacterFetchState {}

class CharacterUninitializedState extends CharacterFetchState {}

class CharacterFetchingState extends CharacterFetchState {}

class CharacterFetchedState extends CharacterFetchState {
  final Character char;
  CharacterFetchedState({@required this.char});
}

class CharacterErrorState extends CharacterFetchState {}

class CharacterEmptyState extends CharacterFetchState {}