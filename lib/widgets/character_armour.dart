import 'package:flutter/material.dart';

void bezierTo(Path path, Offset control, Offset end) {
  path.quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);
}

Path makePath(Size size) {
  Path path = Path();
  path.moveTo(0, 10);
  bezierTo(path, Offset(5, 10), Offset(5, 5));
  path.lineTo(size.width / 2, 0);
  path.lineTo(size.width - 5, 5);
  bezierTo(path, Offset(size.width - 5, 10), Offset(size.width, 10));
  bezierTo(path, Offset(size.width - 5, size.height - 5),
      Offset(size.width / 2, size.height));
  bezierTo(path, Offset(5, size.height - 5), Offset(0, 10));
  path.close();
  return path;
}

// class ArmourPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3
//       ..color = Colors.black;
//     Path path = makePath(size);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }

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
      child: ClipPath(
        clipper: ArmourClipper(),
        child: Container(
          alignment: Alignment(0, 0),
          color: Colors.black,
          child: Text(
            "$armourValue",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      // child: Stack(
      //   children: <Widget>[
      //     // CustomPaint(
      //     //   painter: ArmourPainter(),
      //     //   child: Container(height: 30),
      //     // ),
      //   ],
      // ),
    );
  }
}
