import 'package:flutter/material.dart';

class BlackButton extends StatelessWidget {
  BlackButton({
    this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
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
          onPressed: () {},
          color: Colors.black,
        ),
      ),
    );
  }
}
