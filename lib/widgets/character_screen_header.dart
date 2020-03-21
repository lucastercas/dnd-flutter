import 'dart:math' as math;

import 'package:dnd/widgets/character_status.dart';
import 'package:flutter/material.dart';


class SliverCharacterStatusDelegate extends SliverPersistentHeaderDelegate {
  SliverCharacterStatusDelegate({
    @required this.minHeight,
    @required this.maxHeight,
  });

  final double minHeight;
  final double maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Color.fromRGBO(244, 235, 221, 1),
      child: CharacterStatus(
        expanded: shrinkOffset < 5,
      ),
    );
  }

  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverCharacterStatusDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}
