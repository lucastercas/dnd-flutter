import 'package:dnd/models/character.dart';
import 'package:dnd/screens/character/bloc/character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

class Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: BlocProvider.of<CharacterBloc>(context),
      builder: (context, state) {
        if (state is Updated) return _buildBody(state.character);
        return Container();
      },
    );
  }

  ClipRRect _buildBody(Character character) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        width: ScreenUtil().setWidth(100),
        // To-Do: Get avatar from firebase storage
        child: Image.network(
          character.avatarUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
