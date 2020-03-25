import 'package:dnd/models/character.dart';
import 'package:dnd/screens/character/bloc/character_bloc.dart';
import 'package:dnd/screens/character/widgets/abilities_tab/proficiency_bonus_number.dart';
import 'package:dnd/screens/character/widgets/abilities_tab/proficiency_bonus_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

Path _decorationPath(Size size) {
  Path path = Path();
  path.moveTo(25, 0);
  path.quadraticBezierTo(35, 9, 55, 3);
  // Go to top right
  path.lineTo(size.width - 20, 3);
  path.lineTo(size.width - 3, 12);
  // Go to bottom right
  path.lineTo(size.width - 3, size.height - 6);
  path.lineTo(size.width - 20, size.height + 3);
  // Go to bottom left
  path.lineTo(55, size.height + 3);
  path.quadraticBezierTo(35, size.height - 3, 25, size.height + 5);

  path.moveTo(37, size.height + 5);
  path.quadraticBezierTo(46, size.height / 2, 37, 3);
  return path;
}

class _DecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.grey[700];
    Path path = _decorationPath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_DecorationPainter oldPainter) => true;
}

class ProficiencyBonus extends StatelessWidget {
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
      width: ScreenUtil().setWidth(270),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: ProficiencyBonusNumber(
              proficiencyBonus: character.proficiencyBonus,
            ),
          ),
          Positioned(
            right: 3,
            top: 3,
            child: ProficiencyBonusTitle(),
          ),
          CustomPaint(
            painter: _DecorationPainter(),
            child: Container(height: ScreenUtil().setHeight(50)),
          ),
        ],
      ),
    );
  }
}
