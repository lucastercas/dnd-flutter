import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const int _kIndeterminateLinearDuration = 1800;
const double _kLinearHealthProgressIndicatorHeight = 6.0;

abstract class HealthProgressIndicator extends StatefulWidget {
  const HealthProgressIndicator({
    Key key,
    this.maxHealth,
    this.curHealth,
    this.healing,
  }) : super(key: key);

  final int maxHealth;
  final int curHealth;
  final int healing;

  final Color backgroundColor = const Color.fromRGBO(223, 214, 199, 8);
  final Animation<Color> healthColor = const AlwaysStoppedAnimation<Color>(
    Color.fromRGBO(202, 46, 85, 8),
  );
  final Animation<Color> healingColor = const AlwaysStoppedAnimation<Color>(
    Color.fromRGBO(219, 174, 172, 1),
  );

}

class LinearHealthProgressIndicator extends HealthProgressIndicator {
  const LinearHealthProgressIndicator({
    Key key,
    int maxHealth,
    int curHealth,
    int healing,
    Color backgroundColor,
    Animation<Color> healthColor,
  }) : super(
          key: key,
          maxHealth: maxHealth,
          curHealth: curHealth,
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

  @override
  void initState() {
    super.initState();
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
    return Container(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        minHeight: _kLinearHealthProgressIndicatorHeight,
      ),
      child: CustomPaint(
        painter: _LinearHealthProgressIndicatorPainter(
          backgroundColor: widget.backgroundColor,
          healthColor: widget.healthColor.value,
          healingColor: widget.healingColor.value,
          healthValue: (widget.curHealth / widget.maxHealth),
          healingValue: (widget.healing / widget.maxHealth),
          animationValue: animationValue,
          textDirection: textDirection,
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
    this.backgroundColor,
    this.healthColor,
    this.healingColor,
    this.healthValue,
    this.healingValue,
    this.animationValue,
    @required this.textDirection,
  }) : assert(textDirection != null);

  final Color backgroundColor;
  final Color healthColor;
  final Color healingColor;
  final double healthValue;
  final double healingValue;
  final double animationValue;
  final TextDirection textDirection;

  static const Curve line1Head = Interval(
    0.0,
    750.0 / _kIndeterminateLinearDuration,
    curve: Cubic(0.2, 0.0, 0.8, 1.0),
  );
  static const Curve line1Tail = Interval(
    333.0 / _kIndeterminateLinearDuration,
    (333.0 + 750.0) / _kIndeterminateLinearDuration,
    curve: Cubic(0.4, 0.0, 1.0, 1.0),
  );
  static const Curve line2Head = Interval(
    1000.0 / _kIndeterminateLinearDuration,
    (1000.0 + 567.0) / _kIndeterminateLinearDuration,
    curve: Cubic(0.0, 0.0, 0.65, 1.0),
  );
  static const Curve line2Tail = Interval(
    1267.0 / _kIndeterminateLinearDuration,
    (1267.0 + 533.0) / _kIndeterminateLinearDuration,
    curve: Cubic(0.10, 0.0, 0.45, 1.0),
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bkgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, bkgPaint);

    final healthPaint = Paint()
      ..color = healthColor
      ..style = PaintingStyle.fill;

    final healingPaint = Paint()
      ..color = healingColor
      ..style = PaintingStyle.fill;

    void drawHealthBar(double x, double width) {
      if (width <= 0.0) return;
      double left;
      switch (textDirection) {
        case TextDirection.rtl:
          left = size.width - width - x;
          break;
        case TextDirection.ltr:
          left = x;
          break;
      }
      canvas.drawRect(
        Offset(left, 0.0) & Size(width, size.height),
        healthPaint,
      );
    }

    void drawHealingBar(double x, double width) {
      if (width <= 0.0) return;
      double left;
      switch (textDirection) {
        case TextDirection.rtl:
          left = size.width - width - x;
          break;
        case TextDirection.ltr:
          left = x;
          break;
      }
      canvas.drawRect(
        Offset(left, 0.0) & Size(width, size.height),
        healingPaint,
      );
    }

    drawHealthBar(0.0, healthValue.clamp(0.0, 1.0) * size.width as double);
    drawHealingBar(
      healthValue.clamp(0.0, 1.0) * size.width as double,
      healingValue.clamp(0.0, 1.0) * size.width as double,
    );
  }

  @override
  bool shouldRepaint(_LinearHealthProgressIndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.healthColor != healthColor ||
        oldPainter.healthValue != healthValue ||
        oldPainter.healingValue != healingValue ||
        oldPainter.animationValue != animationValue ||
        oldPainter.textDirection != textDirection;
  }
}
