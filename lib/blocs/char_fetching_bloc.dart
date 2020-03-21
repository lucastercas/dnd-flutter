import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd/blocs/character_event.dart';
import 'package:dnd/blocs/character_state.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterFetchBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository charRepo;
  Character blocChar;

  CharacterFetchBloc({
    this.charRepo,
  }) : assert(charRepo != null);

  @override
  CharacterState get initialState => Initial();

  @override
  Stream<CharacterState> mapEventToState(
    CharacterEvent event,
  ) async* {
    yield Initial();
    print("Mapping char fetching to new state");
    print("$event");
    if (event is CharacterSelectedEvent) {
      Character char = await charRepo.fetchCharacter(
        event.filePath,
        event.charName,
      );
      yield Fetched(char: char);
    } else if (event is CharacterUpdateEvent) {
      
    }

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
