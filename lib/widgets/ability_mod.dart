import 'package:flutter/material.dart';

void bezierTo(Path path, Offset control, Offset end) {
  path.quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);
}

Path makePath(Size size) {

  double mainPoint = 7;
  Path path = Path();
  path.moveTo(0, mainPoint);
  var control1 = new Offset(mainPoint, mainPoint);
  var end1 = new Offset(mainPoint, 1);
  bezierTo(path, control1, end1);

  path.lineTo(size.width - mainPoint, 1);
  var control2 = new Offset(size.width - mainPoint, mainPoint);
  var end2 = new Offset(size.width, mainPoint);
  bezierTo(path, control2, end2);
  
  path.lineTo(size.width, size.height-mainPoint);
  path.lineTo(size.width-mainPoint-5, size.height);
  path.lineTo(0, size.height);
  path.close();
  return path;
}

class AbilityWidgetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.grey[700];
    Path path = makePath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AbilityWidgetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => makePath(size);
  @override
  bool shouldReclip(AbilityWidgetClipper oldClipper) => false;
}

class ModAbility extends StatelessWidget {
  const ModAbility({
    Key key,
    @required this.name,
    @required this.mod,
  }) : super(key: key);

  final String name;
  final int mod;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 75,
      child: Stack(
        children: <Widget>[
          CustomPaint(
            painter: AbilityWidgetPainter(),
            child: Container(height: 100),
          ),
          ClipPath(
            clipper: AbilityWidgetClipper(),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[400]),
              alignment: Alignment(0, 0),
              child: Column(
                children: <Widget>[
                  _buildName(),
                  _buildValue(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValue() {
    return Text(
      "${this.mod}",
      style: TextStyle(
        fontSize: 35,
        
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildName() {
    return Text(
      "${this.name}",
      style: TextStyle(
        
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
