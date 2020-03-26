import 'package:flutter/material.dart';

class BorderClipper extends CustomClipper<Path> {
  final Function generatePath;
  BorderClipper({@required this.generatePath});

  @override
  Path getClip(Size size) => generatePath(size);
  @override
  bool shouldReclip(BorderClipper oldClipper) => false;
}
