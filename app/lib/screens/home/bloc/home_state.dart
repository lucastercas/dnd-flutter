part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
  @override
  String toString() => 'HomeState: {}';
}

class Uninitialized extends HomeState {
  @override
  String toString() => 'UninitializedHomeState: {}';
}

class Fetched extends HomeState {
  final Map<String, Character> characters;
  const Fetched(this.characters);
  @override
  List<Object> get props => [characters];
  @override
  String toString() =>
      'FetchedHomeState: { characters_length: ${characters.length} }';
}
