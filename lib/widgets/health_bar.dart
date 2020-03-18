import 'package:flutter/material.dart';

class HealthBar extends StatefulWidget {
  HealthBar({
    Key key,
    this.maxHealth,
    this.curHealth,
    this.healing,
  }) : super(key: key);

  final int maxHealth;
  final int curHealth;
  final int healing;

  @override
  _HealthBarState createState() => _HealthBarState();
}

class _HealthBarState extends State<HealthBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          child: Container(
            width: 150,
            height: 20,
            child: LinearProgressIndicator(
              value: (widget.curHealth / widget.maxHealth),
              backgroundColor: Color.fromRGBO(223, 214, 199, 8),
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromRGBO(202, 46, 85, 8),
              ),
            ),
          ),
        ),
        Positioned(
          left: 70,
          child: Text(
            "${widget.curHealth}/${widget.maxHealth}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
