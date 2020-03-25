import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AddCharacterEvent extends Equatable {}

class Start extends AddCharacterEvent {
  @override
  List<Object> get props => [];
}

class Update extends AddCharacterEvent {
  final String key;
  final dynamic value;
  Update({@required this.key, @required this.value});
  @override
  List<Object> get props => [key, value];
}

class Finish extends AddCharacterEvent {
  @override
  List<Object> get props => [];
}
