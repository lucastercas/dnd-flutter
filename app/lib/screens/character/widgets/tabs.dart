import 'dart:math' as math;

import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  final TabController _tabController;

  const Tabs({Key key, @required TabController tabController})
      : _tabController = tabController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverTabBarDelegate(
        minHeight: 40,
        maxHeight: 40,
        child: Container(
          color: Color.fromRGBO(224, 215, 201, 1),
          child: TabBar(
            // isScrollable: true,

            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            indicatorWeight: 3,
            indicatorPadding: EdgeInsets.all(0),
            labelPadding: EdgeInsets.all(0),
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person),
                    Text("Abilities", style: TextStyle(fontFamily: 'Cinzel'))
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.book),
                    Text("Spells", style: TextStyle(fontFamily: 'Cinzel')),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.card_travel),
                    Text("Equipments", style: TextStyle(fontFamily: 'Cinzel')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
