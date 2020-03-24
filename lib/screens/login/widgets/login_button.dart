import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButon extends StatelessWidget {
  final Function _onPressed;

  const LoginButon({@required Function onPressed, Key key})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: ScreenUtil().setWidth(330),
        height: ScreenUtil().setHeight(100),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFf4ebdd), Color(0xFFf4e1dd)],
          ),
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFf4e1dd).withOpacity(.3),
              offset: Offset(0.0, 8.0),
              blurRadius: 8.0,
            )
          ],
        ),
        child: MaterialButton(
          color: Colors.transparent,
          onPressed: _onPressed,
          child: Center(
            child: Text(
              "SIGNIN",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
