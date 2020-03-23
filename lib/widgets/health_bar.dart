import 'package:flutter/foundation.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';

const int _kIndeterminateLinearDuration = 1800;

abstract class HealthProgressIndicator extends StatefulWidget {
  const HealthProgressIndicator({
    Key key,
    this.maxHealth,
    this.curHealth,
    this.tempHealth,
    this.healing,
  }) : super(key: key);

  final int maxHealth;
  final int curHealth;
  final int tempHealth;
  final int healing;
}

class LinearHealthProgressIndicator extends HealthProgressIndicator {
  const LinearHealthProgressIndicator({
    Key key,
    int maxHealth,
    int curHealth,
    int tempHealth,
    int healing,
    Color backgroundColor,
  }) : super(
          key: key,
          maxHealth: maxHealth,
          curHealth: curHealth,
          tempHealth: tempHealth,
          healing: healing,
        );

  @override
  _LinearHealthProgressIndicatorState createState() =>
      _LinearHealthProgressIndicatorState();
}

class _LinearHealthProgressIndicatorState
    extends State<LinearHealthProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _showText;
  Animation<Color> _healthColor = AlwaysStoppedAnimation<Color>(
    Colors.red[300],
  );
  Animation<Color> _healingColor = AlwaysStoppedAnimation<Color>(
    Colors.green[300],
  );

  @override
  void initState() {
    super.initState();
    _showText = false;
    _controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateLinearDuration),
      vsync: this,
    );
    // if (widget.value == null) _controller.repeat();
  }

  @override
  void didUpdateWidget(LinearHealthProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (widget.value == null && !_controller.isAnimating)
    //   _controller.repeat();
    // else if (widget.value != null && _controller.isAnimating)
    //   _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildIndicator(BuildContext context, double animationValue,
      TextDirection textDirection) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showText = true;
        });
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            _showText = false;
          });
        });
      },
      child: Container(
        constraints: const BoxConstraints(
          minWidth: double.infinity,
          minHeight: 17,
        ),
        child: CustomPaint(
          painter: _LinearHealthProgressIndicatorPainter(
            curHealth: widget.curHealth,
            curHealthColor: _healthColor.value,
            healing: widget.healing,
            healingColor: _healingColor.value,
            temp: widget.tempHealth,
            maxHealth: widget.maxHealth,
            animationValue: animationValue,
            textDirection: textDirection,
            showText: _showText,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);
    // if (widget.value != null)
    //   return _buildIndicator(context, _controller.value, textDirection);
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget child) {
        return _buildIndicator(context, _controller.value, textDirection);
      },
    );
  }
}

class _LinearHealthProgressIndicatorPainter extends CustomPainter {
  const _LinearHealthProgressIndicatorPainter({
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
      tp.paint(
        canvas,
        offset,
      );
    }

    int max = math.max(maxHealth, curHealth + healing + temp);

    double healthBegin = 0.0;
    double healthSize = (curHealth / max).clamp(0.0, 1.0) * size.width;
    drawBar(
      begin: healthBegin,
      width: healthSize,
      paint: healthPaint,
    );

    double healingBegin = healthBegin + healthSize;
    double healingSize = (healing / max).clamp(0.0, 1.0) * size.width;
    drawBar(
      begin: healingBegin,
      width: healingSize,
      paint: healingPaint,
    );

    double tempBegin = healingBegin + healingSize;
    double tempSize = (temp / max).clamp(0.0, 1.0) * size.width;
    drawBar(
      begin: tempBegin,
      width: tempSize,
      paint: tempPaint,
    );

    showText ? drawText("$curHealth", Offset(healthSize / 2, 0)): SizedBox();

    showText
        ? drawText("$healing", Offset(healingBegin + (healingSize / 2), 0))
        : SizedBox();

    showText
        ? drawText("$temp", Offset(tempBegin + (tempSize / 2), 0))
        : SizedBox();
  }

  @override
  bool shouldRepaint(_LinearHealthProgressIndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.curHealth != curHealth ||
        oldPainter.healing != healing ||
        oldPainter.temp != temp ||
        oldPainter.maxHealth != maxHealth ||
        oldPainter.animationValue != animationValue ||
        oldPainter.showText != showText;
  }
}
