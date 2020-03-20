import 'package:flutter/material.dart';

void bezierTo(Path path, Offset control, Offset end) {
  path.quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);
}

Path makePath(Size size) {
  Path path = Path();

  path.moveTo(0, 10);
  Offset control1 = Offset(5, 10);
  Offset end1 = Offset(5, 5);
  bezierTo(path, control1, end1);

  // Offset control2 = Offset(5, 0);
  // Offset end2 = Offset(size.width / 2, 0);
  // bezierTo(path, control2, end2);
  path.lineTo(size.width / 2, 0);

  path.lineTo(size.width - 5, 5);

  Offset control4 = Offset(size.width - 5, 10);
  Offset end4 = Offset(size.width, 10);
  bezierTo(path, control4, end4);

  Offset control5 = Offset(size.width - 5, size.height - 5);
  Offset end5 = Offset(size.width / 2, size.height);
  bezierTo(path, control5, end5);

  Offset control6 = Offset(5, size.height - 5);
  Offset end6 = Offset(0, 10);
  bezierTo(path, control6, end6);

  path.close();
  return path;
}

class ArmourPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.black;
    Path path = makePath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ArmourClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => makePath(size);
  @override
  bool shouldReclip(ArmourClipper oldClipper) => false;
}

class Armour extends StatelessWidget {
  Armour({this.armourValue});

  final int armourValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      child: Stack(
        children: <Widget>[
          CustomPaint(
            painter: ArmourPainter(),
            child: Container(height: 30),
          ),
          ClipPath(
            clipper: ArmourClipper(),
            child: Container(
              alignment: Alignment(0, 0),
              color: Colors.grey[600],
              child: Text(
                "${armourValue}",
                style: TextStyle(
                  color: Colors.white,
                  
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// SizedBox _buildArmour() {
//   return SizedBox(
//     height: 20,
//     width: 30,
//     child: Text(
//       "${widget.char.curHealth} + ${widget.char.healing}",
//       style: _textStyle,
//     ),
//   );
// }
