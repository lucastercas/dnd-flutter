import 'package:dnd/blocs/authentication/authentication_bloc.dart';
import 'package:dnd/screens/login/bloc/login_bloc.dart';
import 'package:dnd/screens/login/widgets/login_button.dart';
import 'package:dnd/screens/login/widgets/remember_me.dart';
import 'package:dnd/screens/login/widgets/social_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(() {
      _loginBloc.add(
        EmailChanged(email: _emailController.text),
      );
    });
    _passwordController.addListener(() {
      _loginBloc.add(
        PasswordChanged(password: _passwordController.text),
      );
    });
  }

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool _isLoginEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SizedBox(
          width: ScreenUtil().setWidth(700),
          child: Column(
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(180)),
              Container(
                width: double.infinity,
                height: ScreenUtil().setHeight(500),
                decoration: BoxDecoration(
                  color: Color(0xFFe0d7c9),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 15.0),
                      blurRadius: 15.0,
                    ),
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, -10.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(60),
                          fontWeight: FontWeight.bold,
                          letterSpacing: .6,
                        ),
                      ),
                      Text(
                        "Email",
                        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autovalidate: true,
                        autocorrect: false,
                        style: TextStyle(fontFamily: 'Viaoda Libre'),
                        validator: (_) {
                          return !state.isEmailValid ? 'Invalid Email' : null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: "email",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      Text(
                        "Password",
                        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        autovalidate: true,
                        style: TextStyle(fontFamily: 'Viaoda Libre'),
                        autocorrect: false,
                        validator: (_) {
                          return !state.isPasswordValid
                              ? 'Invalid Password'
                              : null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          hintText: "password",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(35)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: ScreenUtil().setSp(28),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(40)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RememberMe(),
                  LoginButon(
                    onPressed: this._isLoginEnabled(state)
                        ? this._onFormSubmitted
                        : null,
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(40)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialIcon(
                    iconData: FontAwesomeIcons.google,
                    onPressed: () {
                      _loginBloc.add(LoginWithGooglePressed());
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
