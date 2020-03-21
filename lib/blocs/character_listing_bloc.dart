import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CharacterListingEvent {}

class StartFetchEvent extends CharacterListingEvent {}

class FetchedEvent extends CharacterListingEvent {
  final List<Character> characters;
  FetchedEvent({@required this.characters});
}

abstract class CharacterListingState {}

class InitialState extends CharacterListingState {}

class FetchingState extends CharacterListingState {}

class UpdateState extends CharacterListingState {
  final List<Character> characters;
  UpdateState({@required this.characters});
}

class CharacterListingBloc
    extends Bloc<CharacterListingEvent, CharacterListingState> {
  final CharacterRepository charRepo;
  StreamSubscription subscription;

  CharacterListingBloc({this.charRepo}) : assert(charRepo != null);

  @override
  CharacterListingState get initialState => InitialState();

  @override
  Stream<CharacterListingState> mapEventToState(
    CharacterListingEvent event,
  ) async* {
    if (event is StartFetchEvent) {
      subscription?.cancel();
      subscription = charRepo.getCharacters().listen(
        (List<Character> characters) {
          add(FetchedEvent(characters: characters));
        },
      );
    }
    if (event is FetchedEvent) {
      yield UpdateState(characters: event.characters);
    }
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
