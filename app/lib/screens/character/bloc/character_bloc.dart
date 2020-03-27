import 'dart:async';

import 'package:dnd/blocs/character_repository.dart';
import 'package:dnd/models/character.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository _characterRepository;
  StreamSubscription _subscription;

  CharacterBloc({@required CharacterRepository characterRepository})
      : assert(characterRepository != null),
        _characterRepository = characterRepository;

  @override
  CharacterState get initialState => Uninitialized();

  @override
  Stream<CharacterState> mapEventToState(CharacterEvent event) async* {
    if (event is Fetch) {
      _subscription?.cancel();
      _subscription = _characterRepository
          .getCharacter(event.charId)
          .listen((Character character) {
        add(Start(character: character));
      });
    } else if (event is Start) {
      yield Updated(character: event.character);
    } else if (event is Update) {
      await _characterRepository.updateCharacter(
        event.characterName,
        event.update,
      );
      // yield Update(character: character);
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
