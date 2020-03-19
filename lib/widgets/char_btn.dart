import 'package:flutter/material.dart';

class CharButton extends StatelessWidget {
  CharButton({
    this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: MaterialButton(
        padding: EdgeInsets.all(2),
        child: Text(
          this.text,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Cinzel',
            fontSize: 12,
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
        onPressed: () {},
        color: Colors.black,
      ),
    );
  }
}
