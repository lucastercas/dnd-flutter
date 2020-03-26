import 'package:flutter/material.dart';

class BorderShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Function generateBorderPath;

  BorderShadowPainter({
    @required this.shadow,
    @required this.clipper,
    @required this.generateBorderPath,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint shadowPaint = shadow.toPaint();
    final Path shadowClipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(shadowClipPath, shadowPaint);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.black;
    final Path path = generateBorderPath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderShadowPainter oldPainter) => true;
}
