import 'package:flutter/material.dart';

class DecorationPainter extends CustomPainter {
  final Function generatePath;
  DecorationPainter({@required this.generatePath});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.grey[800];
    Path path = generatePath(size);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(DecorationPainter oldPainter) => true;
}
