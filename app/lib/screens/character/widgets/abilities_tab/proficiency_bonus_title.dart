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
  path.quadraticBezierTo(7, size.height / 2, 0, 0);

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
      ..strokeWidth = 1.5
      ..color = Colors.black;
    final Path path = _borderPath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BorderShadowPainter oldPainter) => true;
}

class _BorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => _borderPath(size);
  @override
  bool shouldReclip(_BorderClipper oldClipper) => false;
}

class ProficiencyBonusTitle extends StatelessWidget {
  const ProficiencyBonusTitle({
    Key key,
  }) : super(key: key);

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
          height: ScreenUtil().setHeight(50),
          width: ScreenUtil().setWidth(200),
          color: Color(0xFFf4e1dd),
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment(1, 0),
                child: Text(
                  "Proficiency Bonus",
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
