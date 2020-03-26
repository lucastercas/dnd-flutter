import 'package:dnd/widgets/border_clipper.dart';
import 'package:dnd/widgets/border_shadow_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class AbilityModifier extends StatelessWidget {
  final String name;
  final int value;
  final bool proficient;

  const AbilityModifier({
    Key key,
    @required this.name,
    @required this.value,
    @required this.proficient,
  }) : super(key: key);

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
          height: ScreenUtil().setHeight(155),
          color: proficient
              ? Color.fromRGBO(204, 195, 181, 1)
              : Color.fromRGBO(244, 235, 221, 1),
          alignment: Alignment(0, 0),
          child: Column(
            children: <Widget>[
              this._buildName(),
              this._buildValue(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValue() {
    int value = (this.value * 0.5 - 5).floor();
    return Text(
      "$value",
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildName() {
    return Text(
      "${this.name}",
      style: TextStyle(fontWeight: FontWeight.w600),
    );
  }
}

Path _borderPath(Size size) {
  Path path = Path();
  // Top Left Thing
  path.moveTo(2, 7);
  path.quadraticBezierTo(10, 7, 7, 1);
  // Top Right Thing
  path.lineTo(size.width - 7, 1);
  path.quadraticBezierTo(size.width - 10, 7, size.width - 2, 7);
  // Middle Right
  path.lineTo(size.width, 20);
  // Bottom Right Thing
  path.quadraticBezierTo(
    size.width - 7,
    size.height / 3,
    size.width,
    size.height,
  );
  // Bottom Left
  path.lineTo(0, size.height);
  // Bottom Left to Middle
  path.quadraticBezierTo(7, size.height / 3, 0, 20);
  path.close();
  return path;
}
