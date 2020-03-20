import 'package:flutter/material.dart';

class ValueAbility extends StatelessWidget {
  const ValueAbility({
    Key key,
    @required this.value,
  }) : super(key: key);

  final int value;

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
          border: Border.all(
            width: 1.5,
            color: Colors.black,
          ),
        ),
        child: Container(
          height: 30,
          alignment: Alignment(0, 0),
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(254, 245, 231, 1),
          ),
          child: Text(
            "${this.value}",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 15
            ),
          ),
        ),
      ),
    );
  }
}
