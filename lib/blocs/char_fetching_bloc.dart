import 'package:dnd/blocs/character_event.dart';
import 'package:dnd/blocs/character_state.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';

class CharacterFetchBloc
    extends Bloc<CharacterFetchEvent, CharacterFetchState> {
  final CharacterRepository charRepo;

  CharacterFetchBloc({
    this.charRepo,
  }) : assert(charRepo != null);

  @override
  CharacterFetchState get initialState => CharacterUninitializedState();

  @override
  Stream<CharacterFetchState> mapEventToState(
    CharacterFetchEvent event,
  ) async* {
    yield CharacterFetchingState();
    Character char;

    if (event is CharacterSelectedEvent) {
      try {
        char = await charRepo.fetchCharacter(
          event.filePath,
          event.charName,
        );
        if (char == null)
          yield CharacterEmptyState();
        else
          yield CharacterFetchedState(char: char);
      } catch (_) {
        yield CharacterErrorState();
      }
    }
  }
}
