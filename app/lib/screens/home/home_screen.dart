import 'package:dnd/blocs/authentication/authentication_bloc.dart';
import 'package:dnd/blocs/list_character/bloc.dart';
import 'package:dnd/blocs/list_character/event.dart';
import 'package:dnd/blocs/list_character/state.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/character.dart';
import 'package:dnd/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  final CharacterRepository charRepo;
  HomeScreen({@required this.charRepo});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CharacterListingBloc _charListingBloc;

  @override
  void initState() {
    super.initState();
    _charListingBloc = CharacterListingBloc(charRepo: widget.charRepo)
      ..add(StartFetchEvent());
  }

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
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/add-character');
      //   },
      // ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(child: Text("Drawer Header")),
            ListTile(
              title: Text("Log Out"),
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  LoggedOut(),
                );
              },
            ),
          ],
        ),
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Unauthenticated)
            Navigator.pushReplacementNamed(context, '/login');
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Column(
              children: <Widget>[
                if (state is Authenticated) Text(state.displayName),
                BlocProvider<CharacterListingBloc>(
                  create: (BuildContext context) => _charListingBloc,
                  child: _buildBody(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder(
      bloc: _charListingBloc,
      builder: (context, state) {
        if (state is Initial) {
          return Container(child: Text("$state."));
        } else if (state is Update) {
          List<Character> characters = state.characters;
          return SizedBox(
            height: ScreenUtil().setHeight(1000),
            child: ListView.builder(
              itemCount: characters.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/character',
                        arguments: {"charName": characters[index].name},
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(224, 215, 201, 1),
                      ),
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: 75,
                              height: 90,
                              child: Image.asset(
                                "assets/images/${characters[index].avatar}.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(characters[index].name),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _charListingBloc.close();
    super.dispose();
  }
}
