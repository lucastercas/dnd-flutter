import 'package:dnd/repositories/user_repository.dart';
import 'package:dnd/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  RegisterScreen({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(),
    );
  }
}
