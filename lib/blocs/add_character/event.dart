import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CharacterAddEvent extends Equatable {}

class Start extends CharacterAddEvent {
  @override
  List<Object> get props => [];
}

class Update extends CharacterAddEvent {
  final String ability;
  final int value;
  Update({@required this.ability, @required this.value});
  @override
  List<Object> get props => [ability, value];
}

class Finish extends CharacterAddEvent {
  @override
  List<Object> get props => [];
}
