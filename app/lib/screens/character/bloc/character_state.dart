part of 'character_bloc.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();
  @override
  List<Object> get props => [];
  @override
  String toString() => 'CharacterState: { }';
}

class Uninitialized extends CharacterState {
  @override
  List<Object> get props => [];
  @override
  String toString() => "UninitializedCharacterState: { }";
}

class Fetched extends CharacterState {
  final Character character;

  Fetched({@required this.character});
  @override
  List<Object> get props => [character];
  @override
  String toString() => "FetchedCharacterState: { }";
}
