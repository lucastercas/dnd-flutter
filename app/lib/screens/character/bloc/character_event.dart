part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {}

class ScreenStarted extends CharacterEvent {
  final String charId;
  ScreenStarted({@required this.charId});
  @override
  List<Object> get props => [charId];
  @override
  String toString() => 'CharacterScreenStarted: { characterId: $charId }';
}

class Fetch extends CharacterEvent {
  final Character character;
  Fetch({@required this.character});
  @override
  List<Object> get props => [];
  @override
  String toString() => '';
}
