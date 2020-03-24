import 'package:flutter/material.dart';

class BlackButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  BlackButton({
    this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: SizedBox(
        height: 20,
        child: MaterialButton(
          child: child,
          minWidth: 12,
          onPressed: onPressed,
          color: Colors.black,
        ),
      ),
    );
  }
}
