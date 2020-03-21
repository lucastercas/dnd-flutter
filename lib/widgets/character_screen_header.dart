import 'dart:math' as math;
import 'package:dnd/blocs/char_bloc.dart';
import 'package:dnd/blocs/character_listing_event.dart';
import 'package:dnd/blocs/player_state.dart';
import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/character_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliverCharacterStatusDelegate extends SliverPersistentHeaderDelegate {
  SliverCharacterStatusDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    // @required this.char,
  });

  final double minHeight;
  final double maxHeight;
  // final Character char;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final CharacterListingBloc charBloc =
        BlocProvider.of<CharacterListingBloc>(context);
    charBloc.add(CharacterSelectedEvent(filePath: "assets/denna.json"));
    return BlocBuilder(
      bloc: charBloc,
      builder: (BuildContext context, CharacterListingState state) {
        if (state is CharacterUninitializedState) {
          return Container(child: Text("Uninitialized"));
        } else if (state is CharacterEmptyState) {
          return Container(child: Text("Empty"));
        } else if (state is CharacterErrorState) {
          return Container(child: Text("Error"));
        } else if (state is CharacterFetchingState) {
          return Expanded(child: Center(child: CircularProgressIndicator()));
        } else {
          final stateAsCharFetchedState = state as CharacterFetchedState;
          final Character char = stateAsCharFetchedState.char;
          print(char);
          return CharacterStatus(
            char: char,
            expanded: shrinkOffset < 5,
          );
        }
      },
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
    // char != oldDelegate.char;
  }
}
