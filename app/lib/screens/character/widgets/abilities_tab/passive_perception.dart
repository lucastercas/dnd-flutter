import 'package:dnd/models/character.dart';
import 'package:dnd/screens/character/bloc/character_bloc.dart';
import 'package:dnd/screens/character/widgets/abilities_tab/passive_perception_number.dart';
import 'package:dnd/screens/character/widgets/abilities_tab/passive_perception_title.dart';
import 'package:dnd/widgets/decoration_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

class PassivePerception extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: BlocProvider.of<CharacterBloc>(context),
      builder: (context, CharacterState state) {
        if (state is Fetched)
          return _buildBody(state.character);
        // else if (state is Updated)
        //   return _buildBody(state.character);
        else
          return Container();
      },
    );
  }

  Widget _buildBody(Character character) {
    return Container(
      width: ScreenUtil().setWidth(305),
      child: Stack(
        children: <Widget>[
          PassivePerceptionNumber(number: character.proficiencyBonus),
          Positioned(left: 31, top: 5, child: PassivePerceptionTitle()),
          CustomPaint(
            painter: DecorationPainter(generatePath: _decorationPath),
            child: Container(height: ScreenUtil().setHeight(50)),
          ),
        ],
      ),
    );
  }

  Path _decorationPath(Size size) {
    print(size);
    Path path = Path();
    path.moveTo(2, 7);
    // To-Do: Transform this to cubicFor
    path.cubicTo(15, -10, 25, 17, 42, 5);
    // path.quadraticBezierTo(10, 0, 15, 0);
    // path.quadraticBezierTo(35, 12, 45, 5);
    // Go to top right
    path.lineTo(size.width - 20, 5);
    path.lineTo(size.width - 5, 15);
    // Go to bottom right
    path.lineTo(size.width - 5, size.height - 5);
    path.lineTo(size.width - 20, size.height + 5);
    // Go to bottom left
    path.lineTo(42, size.height + 5);
    path.cubicTo(
      25,
      size.height - 5,
      15,
      size.height + 17,
      2,
      size.height + 5,
    );
    // path.quadraticBezierTo(35, size.height - 3, 20, size.height + 10);
    // path.quadraticBezierTo(10, size.height + 10, 2, size.height + 4);
    return path;
  }
}
