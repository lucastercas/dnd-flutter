import 'package:dnd/screens/character/bloc/character_bloc.dart';
import 'package:dnd/screens/character/widgets/abilities_tab/tab_view.dart';
import 'package:dnd/screens/character/widgets/equipments_tab/tab_view.dart';
import 'package:dnd/screens/character/widgets/header_delegate.dart';
import 'package:dnd/screens/character/widgets/spells_tab/tab_view.dart';
import 'package:dnd/screens/character/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CharacterInfo extends StatefulWidget {
  @override
  _CharacterInfoState createState() => _CharacterInfoState();
}

class _CharacterInfoState extends State<CharacterInfo>
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
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        if (state is Uninitialized) {
          return Center(child: CircularProgressIndicator());
        }
        return CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              // To-Do: Check this height
              delegate: CharacterInfoHeaderDelegate(
                minHeight: ScreenUtil().setHeight(170),
                maxHeight: ScreenUtil().setHeight(300),
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
                    SpellsTabView(),
                    EquipmentsTabView(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
