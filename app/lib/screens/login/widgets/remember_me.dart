import 'package:flutter/material.dart';

class RememberMe extends StatefulWidget {
  const RememberMe({Key key}) : super(key: key);

  @override
  _RememberMeState createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  bool _isRememberMeSelected = false;

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2.0, color: Colors.black),
        ),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              )
            : Container(),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 12.0),
        GestureDetector(
          onTap: () {
            setState(() {
              _isRememberMeSelected = !_isRememberMeSelected;
            });
          },
          child: radioButton(_isRememberMeSelected),
        ),
        SizedBox(width: 8.0),
        Text(
          "Remember me",
          style: TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
