import 'package:dnd/blocs/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Authenticated)
          Navigator.pushReplacementNamed(context, '/home');
        if (state is Unauthenticated)
          Navigator.pushReplacementNamed(context, '/login');
      },
      child: Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
