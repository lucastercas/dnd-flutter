import 'package:dnd/blocs/character_event.dart';
import 'package:dnd/blocs/character_state.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository charRepo;

  CharacterBloc({
    this.charRepo,
  }) : assert(charRepo != null);

  @override
  CharacterState get initialState {
    return CharacterUninitializedState();
  }

  @override
  Stream<CharacterState> mapEventToState(
    CharacterEvent event,
  ) async* {
    yield CharacterFetchingState();
    Character char;

    try {
      if (event is CharacterSelectedEvent) {
        char = await charRepo.fetchCharacter(
          event.filePath,
          event.charName,
        );
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
