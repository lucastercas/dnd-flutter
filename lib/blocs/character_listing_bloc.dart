import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterListingEvent {
  final String filePath;
  CharacterListingEvent({@required this.filePath});
}

abstract class CharacterListingState {}

class CharacterListingUninitializedState extends CharacterListingState {}

class CharacterListingFetchedState extends CharacterListingState {
  final List<Character> characters;
  CharacterListingFetchedState({@required this.characters});
}

class CharacterListingBloc
    extends Bloc<CharacterListingEvent, CharacterListingState> {
  final CharacterRepository charRepo;

  CharacterListingBloc({this.charRepo}) : assert(charRepo != null);

  @override
  CharacterListingState get initialState =>
      CharacterListingUninitializedState();

  @override
  Stream<CharacterListingState> mapEventToState(
    CharacterListingEvent event,
  ) async* {
    List<Character> characters;
    characters = await charRepo.fetchCharacters(event.filePath);
    yield CharacterListingFetchedState(characters: characters);
  }
}
