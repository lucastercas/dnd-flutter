import 'package:flutter/material.dart';

class AbilityValue extends StatelessWidget {
  final int value;

  const AbilityValue({Key key, @required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 7.5,
      bottom: 0,
      child: Container(
        alignment: Alignment(0, 0),
        height: 40,
        width: 60,
        decoration: BoxDecoration(
          color: Color.fromRGBO(224, 215, 201, 1),
          shape: BoxShape.circle,
          border: Border.all(width: 1.5, color: Colors.black),
        ),
        child: Container(
          height: 30,
          width: 50,
          alignment: Alignment(0, 0), // Center text on container
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Color.fromRGBO(254, 245, 231, 1)),
          child: Text(
            "${this.value}",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
