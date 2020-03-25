import 'package:dnd/models/character.dart';
import 'package:dnd/screens/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CharacterListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: BlocProvider.of<HomeBloc>(context),
      builder: (context, state) {
        if (state is Fetched) {
          Map<String, Character> characters = state.characters;
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final String key = characters.keys.elementAt(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
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
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/character', arguments: {
                        'charId': key,
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: ScreenUtil().setWidth(200),
                              child: characters[key].avatarUrl != ""
                                  ? FadeInImage.assetNetwork(
                                      placeholder: 'assets/gifs/loading.gif',
                                      image: characters[key].avatarUrl,
                                    )
                                  : Icon(Icons.person, size: 100),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(characters[key].name),
                            Text("LVL. ${characters[key].level}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
