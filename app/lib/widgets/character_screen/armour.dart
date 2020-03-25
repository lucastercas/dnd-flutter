import 'package:flutter/material.dart';

Path makePath(Size size) {
  Path path = Path();
  path.moveTo(0, 10);
  path.quadraticBezierTo(5, 10, 5, 5);
  path.lineTo(size.width / 2, 0);
  path.lineTo(size.width - 5, 5);
  path.quadraticBezierTo(size.width - 5, 10, size.width, 10);
  path.quadraticBezierTo(
    size.width - 5,
    size.height - 5,
    size.width / 2,
    size.height,
  );
  path.quadraticBezierTo(5, size.height - 5, 0, 10);
  path.close();
  return path;
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
      child: ClipPath(
        clipper: ArmourClipper(),
        child: Container(
          alignment: Alignment(0, 0),
          color: Colors.black,
          child: Text(
            "$armourValue",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
