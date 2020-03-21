import 'package:dnd/blocs/char_bloc.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/char.dart';
import 'package:dnd/services/json_parser.dart';
import 'package:dnd/widgets/abilities_tab_view.dart';
import 'package:dnd/widgets/character_screen_tabs.dart';
import 'package:dnd/widgets/character_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterScreen extends StatefulWidget {
  final CharacterRepository charRepo;
  CharacterScreen({this.charRepo});
  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  CharacterListingBloc _charListingBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _charListingBloc = CharacterListingBloc(charRepo: widget.charRepo);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _charListingBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(244, 235, 221, 1000),
          title: Center(
            child: Text(
              "D&D App Mockup",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: SliverCharacterStatusDelegate(
                minHeight: 75,
                maxHeight: 150,
              ),
            )
          ],
        ),
      ),
    );

    return FutureBuilder(
      future: parseJson("assets/denna.json"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Map<String, dynamic> data = snapshot.data;
        if (data == null) return CircularProgressIndicator();
        Character char = Character.fromJson(data);
        return CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            // Character Status
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: SliverCharacterStatusDelegate(
                minHeight: 75,
                maxHeight: 150,
                // char: char,
              ),
            ),
            // Tab Bar
            CharacterTabs(tabController: _tabController),
            SliverToBoxAdapter(
              child: Container(
                // To-Do: How to make this relative?
                height: 600,
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  controller: _tabController,
                  children: <Widget>[
                    AbilitiesTabView(char: char),
                    Container(color: Colors.red, height: 200),
                    Container(color: Colors.green, height: 200),
                  ],
                ),
              ),
            )
            // Tab Bar Views
            // SliverList(
            //   delegate: SliverChildListDelegate([]))
            // )
          ],
        );
      },
    );
  }
}
