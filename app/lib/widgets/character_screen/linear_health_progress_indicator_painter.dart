import 'dart:math' as math;

import 'package:flutter/material.dart';

class LinearHealthProgressIndicatorPainter extends CustomPainter {
  const LinearHealthProgressIndicatorPainter({
    // this.backgroundColor,
    this.curHealth,
    this.curHealthColor,
    this.healing,
    this.healingColor,
    this.maxHealth,
    this.animationValue,
    this.showText,
    this.temp,
    this.tempColor,
    @required this.textDirection,
  }) : assert(textDirection != null);
  final Color backgroundColor = const Color.fromRGBO(223, 214, 199, 8);

  // final Color backgroundColor;
  final int curHealth;
  final Color curHealthColor;

  final int healing;
  final Color healingColor;

  final int temp;
  final Color tempColor;

  final int maxHealth;

  final double animationValue;
  final bool showText;
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bkgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(Offset.zero & size, bkgPaint);

    final healthPaint = Paint()
      ..color = curHealthColor
      ..style = PaintingStyle.fill;

    final healingPaint = Paint()
      ..color = healingColor
      ..style = PaintingStyle.fill;

    final tempPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    void drawBar({double begin, double width, Paint paint}) {
      if (width <= 0.0) return;
      double left = begin;
      canvas.drawRect(
        Offset(left, 0.0) & Size(width, size.height),
        paint,
      );
    }

    void drawText(String text, Offset offset) {
      TextSpan span = TextSpan(
        style: TextStyle(color: Colors.white, fontFamily: 'Cinzel'),
        text: "$text",
      );
      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, offset);
    }

    int max = math.max(maxHealth, curHealth + healing + temp);

    double healthBegin = 0.0;
    double healthSize = (curHealth / max).clamp(0.0, 1.0) * size.width;
    drawBar(begin: healthBegin, width: healthSize, paint: healthPaint);

    double healingBegin = healthBegin + healthSize;
    double healingSize = (healing / max).clamp(0.0, 1.0) * size.width;
    drawBar(begin: healingBegin, width: healingSize, paint: healingPaint);

    double tempBegin = healingBegin + healingSize;
    double tempSize = (temp / max).clamp(0.0, 1.0) * size.width;
    drawBar(begin: tempBegin, width: tempSize, paint: tempPaint);

    if (showText && curHealth > 0) {
      if (curHealth > 0) drawText("$curHealth", Offset(healthSize / 2, 0));
      if (healing > 0)
        drawText("$healing", Offset(healingBegin + (healingSize / 2), 0));
      if (temp > 0) drawText("$temp", Offset(tempBegin + (tempSize / 2), 0));
    }
  }

  @override
  bool shouldRepaint(LinearHealthProgressIndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.curHealth != curHealth ||
        oldPainter.healing != healing ||
        oldPainter.temp != temp ||
        oldPainter.maxHealth != maxHealth ||
        oldPainter.animationValue != animationValue ||
        oldPainter.showText != showText;
  }
}
