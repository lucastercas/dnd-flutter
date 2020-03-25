import 'package:dnd/blocs/authentication/authentication_bloc.dart';
import 'package:dnd/screens/register/bloc/register_bloc.dart';
import 'package:dnd/screens/register/widgets/register_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController =
      TextEditingController(text: "lucasmtercas@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "gxYGQAm8");
  final TextEditingController _usernameController =
      TextEditingController(text: "lucastercas");
  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(() {
      _registerBloc.add(EmailChanged(email: _emailController.text));
    });
    _passwordController.addListener(() {
      _registerBloc.add(PasswordChanged(password: _passwordController.text));
    });
    _usernameController.addListener(() {
      _registerBloc.add(UsernameChanged(username: _usernameController.text));
    });
  }

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  void _onFormSubmitted() {
    _registerBloc.add(Submitted(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _usernameController,
                    autocorrect: false,
                    autovalidate: true,
                    style: TextStyle(fontFamily: 'Viaoda Libre'),
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Username',
                      labelStyle: TextStyle(fontFamily: 'Cinzel'),
                    ),
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Username' : null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autovalidate: true,
                    style: TextStyle(fontFamily: 'Viaoda Libre'),
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                      labelStyle: TextStyle(fontFamily: 'Cinzel'),
                    ),
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    autocorrect: false,
                    autovalidate: true,
                    style: TextStyle(fontFamily: 'Viaoda Libre'),
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                      labelStyle: TextStyle(fontFamily: 'Cinzel'),
                    ),
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  RegisterButton(
                      onPressed: isRegisterButtonEnabled(state)
                          ? _onFormSubmitted
                          : null),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }
}
