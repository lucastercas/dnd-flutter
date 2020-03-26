import 'package:dnd/widgets/border_clipper.dart';
import 'package:dnd/widgets/border_shadow_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Path _borderPath(Size size) {
  Path path = Path();
  path.moveTo(7, 0);
  path.lineTo(size.width - 7, 0);
  path.quadraticBezierTo(
    size.width,
    size.height / 2,
    size.width - 7,
    size.height,
  );
  path.lineTo(7, size.height);
  path.quadraticBezierTo(0, size.height / 2, 7, 0);
  path.close();
  return path;
}

class ProficiencyBonusNumber extends StatelessWidget {
  final int _proficiencyBonus;

  const ProficiencyBonusNumber({
    int proficiencyBonus,
    Key key,
  })  : _proficiencyBonus = proficiencyBonus,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BorderShadowPainter(
        generateBorderPath: _borderPath,
        clipper: BorderClipper(generatePath: _borderPath),
        shadow: BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 5),
          blurRadius: 3,
        ),
      ),
      child: ClipPath(
        clipper: BorderClipper(generatePath: _borderPath),
        child: Container(
          height: ScreenUtil().setHeight(60),
          width: ScreenUtil().setWidth(75),
          alignment: Alignment(0, 0),
          color: Color(0xFFf4e1dd),
          child: Text(
            "$_proficiencyBonus",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: ScreenUtil().setSp(45),
            ),
          ),
        ),
      ),
    );
  }
}
