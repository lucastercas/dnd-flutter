import 'dart:async';

import 'package:dnd/blocs/character_repository.dart';
import 'package:dnd/models/character.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'character_state.dart';
part 'character_event.dart';

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
    if (event is ScreenStarted) {
      _subscription?.cancel();
      _subscription = _characterRepository
          .getCharacter(event.charId)
          .listen((Character character) {
        add(Fetch(character: character));
      });
    } else if (event is Fetch) {
      yield Fetched(character: event.character);
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
