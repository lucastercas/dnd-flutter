import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: 150,
            height: 20,
            child: LinearProgressIndicator(
              value: 0.69,
              backgroundColor: Colors.red,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        ),
        Positioned(
          left: 70,
          child: Text(
            "7/8",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
