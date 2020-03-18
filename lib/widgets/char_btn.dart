import 'package:flutter/material.dart';

class CharButton extends StatelessWidget {
  CharButton({
    this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(5),
      height: 10,
      child: Text(
        this.text,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Sacramento',
          fontSize: 15,
        ),
      ),
      onPressed: () {},
      color: Colors.black,
    );
  }
}
