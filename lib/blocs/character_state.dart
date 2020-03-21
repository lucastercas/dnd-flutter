import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class CharacterState extends Equatable {
  const CharacterState();
  @override
  List<Object> get props => [];
}

class Initial extends CharacterState {}

class Fetching extends CharacterState {}

class Fetched extends CharacterState {
  final Character char;
  const Fetched({@required this.char});
  @override
  List<Object> get props => [char];
}

class Update extends CharacterState {
  final Character char;
  const Update({@required this.char});
  @override
  List<Object> get props => [char];
}
