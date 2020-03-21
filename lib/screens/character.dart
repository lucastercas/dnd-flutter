import 'package:dnd/blocs/char_bloc.dart';
import 'package:dnd/blocs/character_listing_event.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/widgets/abilities_tab_view.dart';
import 'package:dnd/widgets/app_bar.dart';
import 'package:dnd/widgets/character_screen_tabs.dart';
import 'package:dnd/widgets/character_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterScreen extends StatefulWidget {
  final CharacterRepository charRepo;
  final String charName;
  CharacterScreen({this.charRepo, this.charName});
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
    _charListingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _charListingBloc,
      child: Scaffold(
        appBar: MyAppBar(),
        body: CharacterScreenWidget(
          tabController: _tabController,
          charName: widget.charName,
        ),
      ),
    );
  }
}

class CharacterScreenWidget extends StatelessWidget {
  const CharacterScreenWidget({
    Key key,
    @required TabController tabController,
    @required String charName,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final String charName = "oi";

  @override
  Widget build(BuildContext context) {
    final CharacterListingBloc charBloc =
        BlocProvider.of<CharacterListingBloc>(context);
    charBloc.add(CharacterSelectedEvent(filePath: "assets/$charName.json"));
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          floating: true,
          pinned: true,
          delegate: SliverCharacterStatusDelegate(
            minHeight: 75,
            maxHeight: 150,
          ),
        ),
        CharacterTabs(tabController: _tabController),
        SliverToBoxAdapter(
          child: Container(
            // To-Do: How to make this relative?
            height: 600,
            child: TabBarView(
              physics: BouncingScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                AbilitiesTabView(),
                // Container(color: Colors.red, height: 200),
                Container(color: Colors.red, height: 200),
                Container(color: Colors.green, height: 200),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
