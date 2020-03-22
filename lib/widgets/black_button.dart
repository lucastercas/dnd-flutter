import 'package:flutter/material.dart';

class BlackButton extends StatelessWidget {
  BlackButton({
    this.text,
    this.onPressed,
  });

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: SizedBox(
        height: 20,
        child: MaterialButton(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              textBaseline: TextBaseline.alphabetic,
            ),
          ),
          onPressed: onPressed,
          color: Colors.black,
        ),
      ),
    );
  }
}
