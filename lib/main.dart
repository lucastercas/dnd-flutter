import 'package:dnd/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/bloc_delegate.dart';
import 'blocs/repository.dart';
import 'screens/add_character.dart';
import 'screens/character.dart';
import 'screens/home.dart';
import 'screens/login/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  CharacterRepository charRepo = CharacterRepository();
  UserRepository userRepo = UserRepository();
  runApp(MyApp(
    charRepo: charRepo,
    userRepo: userRepo,
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(userRepository: userRepo),
        '/home': (context) => HomeScreen(charRepo: charRepo),
        '/character': (context) => CharacterScreen(charRepo: charRepo),
        '/add-character': (context) => AddCharacterScreen(charRepo: charRepo),
      },
    );
  }
}
