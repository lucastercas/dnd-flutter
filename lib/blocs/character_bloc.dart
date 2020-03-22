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

class SelectedEvent extends CharacterEvent {
  final String charName;
  SelectedEvent({@required this.charName});
}

class FetchedEvent extends CharacterEvent {
  final Character char;
  FetchedEvent({@required this.char});
}

// class CharacterUpdateEvent extends CharacterEvent {
//   final Character char;
//   CharacterUpdateEvent({@required this.char});
// }

abstract class CharacterState extends Equatable {
  const CharacterState();
  @override
  List<Object> get props => [];
}

class Initial extends CharacterState {}

// class Fetching extends CharacterState {}

class FetchedState extends CharacterState {
  final Character char;
  const FetchedState({@required this.char});
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
    if (event is SelectedEvent) {
      subscription?.cancel();
      subscription = charRepo.getCharacter(event.charName).listen(
        (Character char) {
          add(FetchedEvent(char: char));
        },
      );
    } else if (event is FetchedEvent) {
      yield FetchedState(char: event.char);
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
