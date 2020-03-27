part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {}

class Fetch extends CharacterEvent {
  final String charId;
  Fetch({@required this.charId});
  @override
  List<Object> get props => [charId];
  @override
  String toString() => 'CharacterFetch: { characterId: $charId }';
}

class Start extends CharacterEvent {
  final Character character;
  Start({@required this.character});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'NewCharacter: {name: ${character.name} }';
}

class Update extends CharacterEvent {
  final String characterName;
  final Map<String, dynamic> update;
  Update({@required this.characterName, @required this.update});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'UpdateCharacter: {name: ${characterName} }';
}
