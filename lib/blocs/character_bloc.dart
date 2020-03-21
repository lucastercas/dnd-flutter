import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CharacterEvent {}

class CharacterChangeHealthEvent extends CharacterEvent {
  final int amount;
  CharacterChangeHealthEvent({@required this.amount});
}

abstract class CharacterState {}

class CharacterNormalState extends CharacterState {}

class CharacterHealthChangeState extends CharacterState {
  final int amount;
  final Character char;

  CharacterHealthChangeState({this.amount, this.char}) {
    char.curHealth += amount;
  }
}

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final Character char;

  CharacterBloc({@required this.char});

  @override
  CharacterState get initialState => CharacterNormalState();

  @override
  Stream<CharacterState> mapEventToState(CharacterEvent event) async* {
    if (event is CharacterChangeHealthEvent) {
      char.curHealth += event.amount;
    }
  }
}
