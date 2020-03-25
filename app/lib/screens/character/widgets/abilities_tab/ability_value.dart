import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class AbilityValue extends StatelessWidget {
  final int value;

  const AbilityValue({Key key, @required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 6.5,
      bottom: 10,
      child: Container(
        height: ScreenUtil().setHeight(70),
        width: ScreenUtil().setWidth(115),
        alignment: Alignment(0, 0), // Center text on container
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: Colors.black),
          shape: BoxShape.circle,
          color: Color.fromRGBO(254, 245, 231, 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(3, 5),
              blurRadius: 2,
            )
          ],
        ),
        child: Text(
          "${this.value}",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: ScreenUtil().setSp(30),
          ),
        ),
      ),
    );
  }
}
