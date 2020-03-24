import 'package:dnd/repositories/user_repository.dart';
import 'package:dnd/screens/register/register_screen.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final UserRepository _userRepository;

  RegisterButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(userRepository: _userRepository);
          }),
        );
      },
    );
  }
}
