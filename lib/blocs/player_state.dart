import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';

abstract class CharacterListingState {}

class CharacterUninitializedState extends CharacterListingState {}

class CharacterFetchingState extends CharacterListingState {}

class CharacterFetchedState extends CharacterListingState {
  final Character char;
  CharacterFetchedState({@required this.char});
}

class CharacterErrorState extends CharacterListingState {}

class CharacterEmptyState extends CharacterListingState {}