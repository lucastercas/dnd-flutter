part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class ScreenStarted extends HomeEvent {
  final String playerUID;
  ScreenStarted({@required this.playerUID});
  @override
  List<Object> get props => [playerUID];
  @override
  String toString() => 'HomeScreenStarted { playerUID: $playerUID }';
}
