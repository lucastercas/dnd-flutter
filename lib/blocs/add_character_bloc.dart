import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CharacterAddEvent {}

class Start extends CharacterAddEvent {}

class Update extends CharacterAddEvent {
  final String ability;
  final int value;
  Update({this.ability, this.value});
}

class Finish extends CharacterAddEvent {}

abstract class CharacterAddState {}

class Initial extends CharacterAddState {
  final Character char;
  Initial({@required this.char});
}

class Updated extends CharacterAddState {
  final Character char;
  Updated({@required this.char});
}

class Finished extends CharacterAddState {}

class CharacterAddBloc extends Bloc<CharacterAddEvent, CharacterAddState> {
  final Character char = Character();
  final CharacterRepository charRepo;
  CharacterAddBloc({this.charRepo});

  @override
  CharacterAddState get initialState => Initial(char: char);

  @override
  Stream<CharacterAddState> mapEventToState(CharacterAddEvent event) async* {
    if (event is Update) {
      char.updateAbility(name: event.ability, value: event.value);
      yield Updated(char: char);
    } else if (event is Finish) {
      print("Finish this BIIITCH");
      print("${char.abilities["str"]}");
      await charRepo.addCharacter();
      yield Finished();
    }
  }
}
