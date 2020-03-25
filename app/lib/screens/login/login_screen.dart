import 'package:dnd/blocs/authentication/authentication_bloc.dart';
import 'package:dnd/repositories/user_repository.dart';
import 'package:dnd/screens/login/bloc/login_bloc.dart';
import 'package:dnd/screens/login/widgets/login_form.dart';
import 'package:dnd/screens/login/widgets/register_button.dart';
import 'package:dnd/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      allowFontScaling: true,
      width: 750,
      height: 1334,
    );
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Color(0xFFe0d7c9),
      resizeToAvoidBottomInset: true,
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isFailure) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(




                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Login Failure'), Icon(Icons.error)],
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
            }
            if (state.isSubmitting) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()


                
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Logging In...'),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
            }
            if (state.isSuccess) {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(children: <Widget>[]), // To-Do: Add logo or image
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      LoginForm(),
                      RegisterButton(userRepository: _userRepository),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
