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

class _BorderShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _BorderShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint shadowPaint = shadow.toPaint();
    final Path shadowClipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(shadowClipPath, shadowPaint);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;
    final Path path = _borderPath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _BorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => _borderPath(size);

  @override
  bool shouldReclip(_BorderClipper oldClipper) => false;
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
      painter: _BorderShadowPainter(
        clipper: _BorderClipper(),
        shadow: BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 5),
          blurRadius: 3,
        ),
      ),
      child: ClipPath(
        clipper: _BorderClipper(),
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
