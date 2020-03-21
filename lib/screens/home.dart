import 'package:dnd/blocs/character_listing_bloc.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    _charListingBloc = CharacterListingBloc(charRepo: widget.charRepo);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _charListingBloc,
      child: Scaffold(
        appBar: MyAppBar(),
        body: HomeScreenWidget(),
        backgroundColor: Color.fromRGBO(244, 235, 221, 1),
      ),
    );
  }

  @override
  void dispose() {
    _charListingBloc.close();
    super.dispose();
  }
}

class HomeScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final charListingBloc = BlocProvider.of<CharacterListingBloc>(
      context,
    );
    charListingBloc.add(StartFetchEvent());
    return BlocBuilder(
      bloc: charListingBloc,
      builder: (BuildContext context, CharacterListingState state) {
        if (state is InitialState) {
          return Container(child: Text("$state."));
        } else if (state is UpdateState) {
          List<Character> characters = state.characters;
          return ListView.builder(
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
          );
        }
      },
    );
  }
}
