import 'package:dnd/blocs/authentication/authentication_bloc.dart';
import 'package:dnd/blocs/character_repository.dart';
import 'package:dnd/screens/character/bloc/character_bloc.dart';
import 'package:dnd/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/character_info.dart';

class CharacterScreen extends StatelessWidget {
  static const routeName = '/character';
  final CharacterRepository charRepo;
  CharacterScreen({
    @required this.charRepo,
  });
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      allowFontScaling: true,
      width: 750,
      height: 1334,
    );
    final dynamic args = ModalRoute.of(context).settings.arguments;
    final String charId = args["charId"];
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Color(0xFFf4ebdd),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, authState) {
          if (authState is Unauthenticated)
            Navigator.pushReplacementNamed(context, '/login');
        },
        child: BlocProvider<CharacterBloc>(
          create: (context) => CharacterBloc(characterRepository: charRepo)
            ..add(ScreenStarted(charId: charId)),
          child: CharacterInfo(),
        ),
      ),
    );
  }
}

