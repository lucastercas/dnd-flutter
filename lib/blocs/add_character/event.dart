import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AddCharacterEvent extends Equatable {}

class Start extends AddCharacterEvent {
  @override
  List<Object> get props => [];
}

class Update extends AddCharacterEvent {
  final String ability;
  final int value;
  Update({@required this.ability, @required this.value});
  @override
  List<Object> get props => [ability, value];
}

class Finish extends AddCharacterEvent {
  @override
  List<Object> get props => [];
}
