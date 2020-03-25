import 'dart:math' as math;

import 'package:dnd/screens/character/widgets/header.dart';
import 'package:flutter/material.dart';

class CharacterInfoHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;

  CharacterInfoHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Color.fromRGBO(244, 235, 221, 1),
      child: CharacterInfoHeader(expanded: shrinkOffset < 5),
    );
  }

  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(CharacterInfoHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}
