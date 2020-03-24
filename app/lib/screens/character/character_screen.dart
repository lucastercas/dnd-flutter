import 'package:dnd/blocs/character/bloc.dart';
import 'package:dnd/blocs/character/event.dart';
import 'package:dnd/blocs/character/state.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/widgets/app_bar.dart';
import 'package:dnd/widgets/character_screen/header_delegate.dart';
import 'package:dnd/widgets/character_screen/tab_view.dart';
import 'package:dnd/widgets/character_screen/tabs.dart';
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

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context).settings.arguments;
    final String charName = args["charName"];
    return BlocProvider(
      create: (BuildContext context) =>
          CharacterFetchBloc(charRepo: widget.charRepo)
            ..add(Select(
              characterName: charName,
            )),
      child: Scaffold(appBar: MyAppBar(), body: CharacterScreenBody()),
    );
  }
}

class CharacterScreenBody extends StatefulWidget {
  const CharacterScreenBody({Key key}) : super(key: key);

  @override
  _CharacterScreenBodyState createState() => _CharacterScreenBodyState();
}

class _CharacterScreenBodyState extends State<CharacterScreenBody>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<CharacterFetchBloc>(context),
      builder: (BuildContext context, CharacterState state) {
        if (state is Initial) {
          return SizedBox.expand(child: CircularProgressIndicator());
        } else {
          return CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: HeaderDelegate(
                  minHeight: 75,
                  maxHeight: 150,
                ),
              ),
              Tabs(tabController: _tabController),
              SliverToBoxAdapter(
                child: Container(
                  // To-Do: How to make this relative?
                  height: 600,
                  child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    controller: _tabController,
                    children: <Widget>[
                      // To-Do: Make spells and equipment screen
                      AbilitiesTabView(),
                      Container(color: Colors.red, height: 100),
                      Container(color: Colors.green, height: 100),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
