import 'package:dnd/screens/character/widgets/abilities_tab/ability_mod.dart';
import 'package:dnd/screens/character/widgets/abilities_tab/ability_value.dart';
import 'package:dnd/widgets/decoration_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class Ability extends StatelessWidget {
  final String name;
  final int value;
  final bool proficient;

  const Ability({
    Key key,
    @required this.name,
    @required this.value,
    @required this.proficient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.only(left: 4, right: 4),
      child: Stack(
        children: <Widget>[
          AbilityModifier(name: name, value: value, proficient: proficient),
          CustomPaint(
            painter: DecorationPainter(generatePath: _decorationPath),
            child: Container(height: 80),
          ),
          AbilityValue(value: value),
        ],
      ),
    );
  }
}

Path _decorationPath(Size size) {
  Path path = Path();
  // Top left curve
  path.moveTo(2, 7);
  path.quadraticBezierTo(10, 7, 7, 1);
  // Go to right
  path.lineTo(size.width - 7, 1);
  // Top right curve
  path.quadraticBezierTo(size.width - 10, 7, size.width - 2, 7);
  // Right decoration 1
  path.quadraticBezierTo(size.width - 7, 30, size.width, 30);
  // Right decoration 2
  path.quadraticBezierTo(
    size.width - 2,
    size.height / 1.5,
    size.width - 5,
    size.height - 15,
  );
  // Right decoration 3
  path.quadraticBezierTo(
    size.width + 5,
    size.height - 12,
    size.width - 2,
    size.height - 5,
  );
  path.lineTo(size.width - 20, size.height + 13);
  // Right decoration 4
  path.quadraticBezierTo(
    size.width - 7,
    size.height + 10,
    size.width - 5,
    size.height + 6,
  );
  // Go to left
  path.quadraticBezierTo(size.width / 2, size.height + 3, 5, size.height + 7);
  // Left decoration 4
  path.quadraticBezierTo(7, size.height + 10, 20, size.height + 13);
  // path.lineTo(18.5, size.height + 10.5);
  path.lineTo(2, size.height - 5);
  // Left decoration 3
  path.quadraticBezierTo(-5, size.height - 12, 5, size.height - 15);
  // Left decoration 2
  path.quadraticBezierTo(2, size.height / 1.5, 0, 30);
  // Left decoration 1
  path.quadraticBezierTo(7, 30, 2, 7);
  path.close();
  return path;
}
