import 'package:dnd/blocs/character_listing_event.dart';
import 'package:dnd/blocs/player_state.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';

class CharacterListingBloc
    extends Bloc<CharacterListingEvent, CharacterListingState> {
  final CharacterRepository charRepo;

  CharacterListingBloc({
    this.charRepo,
  }) : assert(charRepo != null);

  @override
  CharacterListingState get initialState {
    return CharacterUninitializedState();
  }

  @override
  Stream<CharacterListingState> mapEventToState(
    CharacterListingEvent event,
  ) async* {
    yield CharacterFetchingState();
    Character char;

    try {
      if (event is CharacterSelectedEvent) {
        char = await charRepo.fetchCharacter(event.filePath);
      }
      if (char == null)
        yield CharacterEmptyState();
      else
        yield CharacterFetchedState(char: char);
    } catch (_) {
      yield CharacterErrorState();
    }
  }
}
