import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;

  SocialIcon({@required this.iconData, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // gradient: LinearGradient(
          //   colors: colors,
          //   tileMode: TileMode.clamp,
          // ),
        ),
        child: RawMaterialButton(
          shape: CircleBorder(),
          onPressed: onPressed,
          child: Icon(iconData, color: Colors.white),
        ),
      ),
    );
  }
}
