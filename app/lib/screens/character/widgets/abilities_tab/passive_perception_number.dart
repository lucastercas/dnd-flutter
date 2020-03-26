import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PassivePerceptionNumber extends StatelessWidget {
  final int number;
  PassivePerceptionNumber({@required this.number});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(70),
      width: ScreenUtil().setWidth(75),
      alignment: Alignment(0, 0),
      child: Text(
        "$number",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: ScreenUtil().setSp(45),
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFf4e1dd),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(3, 5),
            blurRadius: 3,
          )
        ],
        border: Border.all(
          color: Colors.black,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
    );
  }
}
