import 'package:dnd/models/character.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CharacterListingEvent extends Equatable {}

class StartFetchEvent extends CharacterListingEvent {
  @override
  List<Object> get props => [];
}

class FetchedEvent extends CharacterListingEvent {
  final List<Character> characters;
  FetchedEvent({@required this.characters});
  @override
  List<Object> get props => [characters];
}
