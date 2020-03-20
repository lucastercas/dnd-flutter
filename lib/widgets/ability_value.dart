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
        decoration: BoxDecoration(
          color: Colors.grey[350],
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: Colors.grey[700],
          ),
        ),
        child: Text(
          "${this.value}",
          style: TextStyle(
            color: Colors.black,
            
            fontWeight: FontWeight.w500,
          ),
        ),
        height: 40,
        width: 60,
      ),
    );
  }
}
