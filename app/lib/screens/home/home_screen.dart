import 'package:dnd/blocs/authentication/authentication_bloc.dart';
import 'package:dnd/blocs/character_repository.dart';
import 'package:dnd/screens/home/bloc/home_bloc.dart';
import 'package:dnd/screens/home/widgets/character_listing.dart';
import 'package:dnd/widgets/app_bar.dart';
import 'package:dnd/widgets/default_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  final _characterRepository;

  HomeScreen({@required CharacterRepository characterRepository})
      : _characterRepository = characterRepository;

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
      backgroundColor: Color(0xFFf4ebdd),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add-character');
        },
      ),
      drawer: DefaultDrawer(),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, authState) {
          if (authState is Unauthenticated)
            Navigator.pushReplacementNamed(context, '/login');
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) {
            var state = authState as Authenticated;
            return Column(
              children: <Widget>[
                Text(state.user["displayName"]),
                BlocProvider<HomeBloc>(
                  create: (BuildContext context) =>
                      HomeBloc(characterRepository: _characterRepository)
                        ..add(ScreenStarted(playerUID: state.user['uid'])),
                  child: SizedBox(
                    height: ScreenUtil().setHeight(1000),
                    child: CharacterListing(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
