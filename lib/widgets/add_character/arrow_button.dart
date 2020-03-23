import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;

  ArrowButton({
    @required this.onPressed,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
      height: 25,
      minWidth: 20,
      child: this.child,
      onPressed: this.onPressed,
      color: Colors.black,
    );
  }
}
