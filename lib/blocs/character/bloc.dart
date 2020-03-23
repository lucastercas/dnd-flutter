import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd/blocs/character/event.dart';
import 'package:dnd/blocs/character/state.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/character.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    if (event is Select) {
      subscription?.cancel();
      subscription = charRepo.getCharacter(event.characterName).listen(
        (Character character) {
          add(Fetch(character: character));
        },
      );
    } else if (event is Fetch) {
      yield Fetched(character: event.character);
    } else if (event is Update) {
      charRepo.updateCharacter(
        event.characterName,
        event.updateData,
      );
      // yield Update();
    }
    // yield Initial();
    // print("Mapping character fetching to new state");
    // print("$event");
    // if (event is CharacterSelectedEvent) {
    //   Character character = await charRepo.fetchCharacter(
    //     event.filePath,
    //     event.charName,
    //   );
    //   yield Fetched(character: character);
    // } else if (event is CharacterUpdateEvent) {}

    // if (event is CharacterSelectedEvent) {
    //   try {
    //     Character character = await charRepo.fetchCharacter(
    //       event.filePath,
    //       event.charName,
    //     );
    //     this.blocChar = character;
    //     print(character.name);
    //     if (character != null)
    //       yield this.blocChar;
    //     else
    //       yield null;
    //   } catch (_) {
    //     yield null;
    //   }
    // }
  }
}
