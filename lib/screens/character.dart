import 'package:dnd/blocs/char_bloc.dart';
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
  CharacterBloc _charBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _charBloc = CharacterBloc(charRepo: widget.charRepo);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _charBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context).settings.arguments;
    final String charName = args["charName"];
    return BlocProvider(
      create: (BuildContext context) => _charBloc,
      child: Scaffold(
        appBar: MyAppBar(),
        body: CharacterScreenWidget(
          tabController: _tabController,
          charName: charName,
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
        charName = charName,
        super(key: key);

  final TabController _tabController;
  final String charName;

  @override
  Widget build(BuildContext context) {
    final CharacterBloc charBloc = BlocProvider.of<CharacterBloc>(
      context,
    );
    charBloc.add(CharacterSelectedEvent(
      filePath: "assets/characters.json",
      charName: charName,
    ));
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
