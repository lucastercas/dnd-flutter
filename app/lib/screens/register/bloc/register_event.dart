part of 'register_bloc.dart';

/// Events:
/// EmailChanged, passwordChanged, Submitted

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object> get props => [];
}

class UsernameChanged extends RegisterEvent {
  final String username;
  const UsernameChanged({@required this.username});

  @override
  List<Object> get props => [username];
  @override
  String toString() => 'UsernameChanged { username :$username }';
}

class EmailChanged extends RegisterEvent {
  final String email;
  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];
  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;
  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];
  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  const Submitted({
    @required this.username,
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [username, email, password];
  @override
  String toString() =>
      'Submitted { username: $username, email: $email, password: $password }';
}
