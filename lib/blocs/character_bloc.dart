import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();
  @override
  List<Object> get props => [];
}

class CharacterSelectedEvent extends CharacterEvent {
  final String filePath;
  final String charName;

  CharacterSelectedEvent({
    @required this.filePath,
    @required this.charName,
  });
}

class CharacterUpdateEvent extends CharacterEvent {
  final Character char;
  CharacterUpdateEvent({@required this.char});
}

abstract class CharacterState extends Equatable {
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

class CharacterFetchBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository charRepo;
  StreamSubscription subscription;

  CharacterFetchBloc({
    this.charRepo,
  }) : assert(charRepo != null);

  @override
  CharacterState get initialState => Initial();

  @override
  Stream<CharacterState> mapEventToState(
    CharacterEvent event,
  ) async* {
    if (event is CharacterSelectedEvent) {
      subscription?.cancel();
      subscription = charRepo.getCharacter(event.charName).listen((event) {
        print(event);
      });
    }
    // yield Initial();
    // print("Mapping char fetching to new state");
    // print("$event");
    // if (event is CharacterSelectedEvent) {
    //   Character char = await charRepo.fetchCharacter(
    //     event.filePath,
    //     event.charName,
    //   );
    //   yield Fetched(char: char);
    // } else if (event is CharacterUpdateEvent) {}

    // if (event is CharacterSelectedEvent) {
    //   try {
    //     Character char = await charRepo.fetchCharacter(
    //       event.filePath,
    //       event.charName,
    //     );
    //     this.blocChar = char;
    //     print(char.name);
    //     if (char != null)
    //       yield this.blocChar;
    //     else
    //       yield null;
    //   } catch (_) {
    //     yield null;
    //   }
    // }
  }
}
