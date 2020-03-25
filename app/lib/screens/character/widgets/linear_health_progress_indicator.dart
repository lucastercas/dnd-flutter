import 'package:dnd/screens/character/widgets/linear_health_progress_indicator_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const int _kIndeterminateLinearDuration = 1800;

class LinearHealthProgressIndicator extends StatefulWidget {
  final int maxHealth;
  final int curHealth;
  final int tempHealth;
  final int healing;
  final Color backgroundColor;

  const LinearHealthProgressIndicator({
    Key key,
    this.maxHealth,
    this.curHealth,
    this.tempHealth,
    this.healing,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _LinearHealthProgressIndicatorState createState() =>
      _LinearHealthProgressIndicatorState();
}

class _LinearHealthProgressIndicatorState
    extends State<LinearHealthProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _showText;
  Animation<Color> _healthColor =
      AlwaysStoppedAnimation<Color>(Colors.red[300]);
  Animation<Color> _healingColor =
      AlwaysStoppedAnimation<Color>(Colors.green[300]);

  @override
  void initState() {
    super.initState();
    _showText = false;
    _controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateLinearDuration),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget child) {
        return _buildIndicator(
          context,
          _controller.value,
          Directionality.of(context),
        );
      },
    );
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
        constraints:
            const BoxConstraints(minWidth: double.infinity, minHeight: 17),
        child: CustomPaint(
          painter: LinearHealthProgressIndicatorPainter(
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
}
