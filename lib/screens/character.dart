import 'package:dnd/blocs/character_bloc.dart';
import 'package:dnd/blocs/character_event.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/widgets/abilities_tab_view.dart';
import 'package:dnd/widgets/app_bar.dart';
import 'package:dnd/widgets/character_screen_tabs.dart';
import 'package:dnd/widgets/character_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterScreen extends StatefulWidget {
  static const routeName = '/character';
  final CharacterRepository charRepo;
  CharacterScreen({
    @required this.charRepo,
  });
  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context).settings.arguments;
    final String charName = args["charName"];
    return BlocProvider(
      create: (BuildContext context) =>
          CharacterFetchBloc(charRepo: widget.charRepo)
            ..add(
              CharacterSelectedEvent(
                filePath: "assets/characters.json",
                charName: charName,
              ),
            ),
      child: Scaffold(
        appBar: MyAppBar(),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: SliverCharacterStatusDelegate(
                minHeight: 75,
                maxHeight: 150,
              ),
            ),
            // CharacterTabs(tabController: _tabController),
            // SliverToBoxAdapter(
            //   child: Container(
            //     // To-Do: How to make this relative?
            //     height: 600,
            //     child: TabBarView(
            //       physics: BouncingScrollPhysics(),
            //       controller: _tabController,
            //       children: <Widget>[
            //         AbilitiesTabView(),
            //         // Container(color: Colors.red, height: 200),
            //         Container(color: Colors.red, height: 200),
            //         Container(color: Colors.green, height: 200),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
