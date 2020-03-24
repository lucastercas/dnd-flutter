import 'package:dnd/blocs/authentication/authentication_bloc.dart';
import 'package:dnd/repositories/user_repository.dart';
import 'package:dnd/screens/home/home_screen.dart';
import 'package:dnd/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/bloc_delegate.dart';
import 'blocs/repository.dart';
import 'screens/login/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  CharacterRepository charRepo = CharacterRepository();
  UserRepository userRepo = UserRepository();
  runApp(BlocProvider(
    create: (context) =>
        AuthenticationBloc(userRepository: userRepo)..add(AppStarted()),
    child: MyApp(
      charRepo: charRepo,
      userRepo: userRepo,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final CharacterRepository charRepo;
  final UserRepository userRepo;

  MyApp({@required this.charRepo, @required this.userRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Cinzel',
        backgroundColor: Color(0xFFf2d7c9),
      ),
      debugShowCheckedModeBanner: true,
      title: 'D&D ',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(userRepository: userRepo),
        '/home': (context) => HomeScreen(charRepo: charRepo),
        // '/character': (context) => CharacterScreen(charRepo: charRepo),
        // '/add-character': (context) => AddCharacterScreen(charRepo: charRepo),
      },
    );
  }
}
