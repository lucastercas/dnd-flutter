import 'dart:math' as math;

import 'package:dnd/models/char.dart';
import 'package:dnd/services/json_parser.dart';
import 'package:dnd/widgets/abilities_tab_view.dart';
import 'package:dnd/widgets/character_screen_tabs.dart';
import 'package:dnd/widgets/character_status.dart';
import 'package:flutter/material.dart';

class CharacterScreen extends StatefulWidget {
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
  Widget build(BuildContext context) {
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
              pinned: true,
              delegate: _SliverCharacterHeaderDelegate(
                minHeight: 75,
                maxHeight: 150,
                char: char,
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

class _SliverCharacterHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverCharacterHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.char,
  });

  final double minHeight;
  final double maxHeight;
  final Character char;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Color.fromRGBO(244, 235, 221, 1),
      child: CharacterStatus(
        char: char,
        expanded: shrinkOffset < 5,
      ),
    );
  }

  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverCharacterHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}
