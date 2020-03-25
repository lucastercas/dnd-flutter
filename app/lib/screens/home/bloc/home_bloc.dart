import 'package:dnd/blocs/character_repository.dart';
import 'package:dnd/models/character.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CharacterRepository _characteRepository;

  HomeBloc({@required CharacterRepository characterRepository})
      : assert(characterRepository != null),
        _characteRepository = characterRepository;

  @override
  HomeState get initialState => Uninitialized();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is ScreenStarted) {
      Map<String, Character> characters =
          await _characteRepository.getCharacters(event.playerUID);
      yield Fetched(characters);
    }
  }
}
