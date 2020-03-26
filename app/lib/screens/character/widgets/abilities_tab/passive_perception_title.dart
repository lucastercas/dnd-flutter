import 'package:dnd/widgets/border_clipper.dart';
import 'package:dnd/widgets/border_shadow_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Path _borderPath(Size size) {
  Path path = Path();
  // Go to top right
  path.lineTo(size.width - 5, 0);
  path.lineTo(size.width, 5);
  // Go to bottom right
  path.lineTo(size.width, size.height - 5);
  path.lineTo(size.width - 5, size.height);
  // Go to bottom left
  path.lineTo(0, size.height);
  // Go to top left
  path.quadraticBezierTo(10, size.height / 2, 0, 0);
  path.close();
  return path;
}

class PassivePerceptionTitle extends StatelessWidget {
  const PassivePerceptionTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BorderShadowPainter(
        clipper: BorderClipper(generatePath: _borderPath),
        generateBorderPath: _borderPath,
        shadow: BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 5),
          blurRadius: 3,
        ),
      ),
      child: ClipPath(
        clipper: BorderClipper(generatePath: _borderPath),
        child: Container(
          height: ScreenUtil().setHeight(50),
          width: ScreenUtil().setWidth(230),
          color: Color(0xFFf4e1dd),
          child: Container(
            alignment: Alignment(1, 0),
            child: Text("Passive Perception",
                style: TextStyle(fontSize: ScreenUtil().setSp(22))),
          ),
        ),
      ),
    );
  }
}
