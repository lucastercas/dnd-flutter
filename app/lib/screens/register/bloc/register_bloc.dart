import 'dart:async';

import 'package:dnd/repositories/user_repository.dart';
import 'package:dnd/screens/login/bloc/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transformEvents(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is UsernameChanged)
      yield state.update(
        isValidUsername: Validators.isValidUsername(event.username),
      );
    if (event is EmailChanged)
      yield state.update(isEmailValid: Validators.isValidEmail(event.email));
    else if (event is PasswordChanged)
      yield state.update(
        isPasswordValid: Validators.isValidPassword(event.password),
      );
    else if (event is Submitted)
      yield* _mapFormSubmittedToState(
        event.username,
        event.email,
        event.password,
      );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String username,
    String email,
    String password,
  ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
        username: username,
        email: email,
        password: password,
      );
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
