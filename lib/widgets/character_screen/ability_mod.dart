import 'package:flutter/material.dart';

Path decorationPath(Size size) {
  Path path = Path();
  // Top left curve
  path.moveTo(2, 7);
  path.quadraticBezierTo(10, 7, 7, 1);
  // Go to right
  path.lineTo(size.width - 7, 1);
  // Top right curve
  path.quadraticBezierTo(size.width - 10, 7, size.width - 2, 7);
  // Right decoration 1
  path.quadraticBezierTo(size.width - 7, 30, size.width, 30);
  // Right decoration 2
  path.quadraticBezierTo(
    size.width - 2,
    size.height / 1.5,
    size.width - 5,
    size.height - 15,
  );
  // Right decoration 3
  path.quadraticBezierTo(
    size.width + 5,
    size.height - 12,
    size.width - 2,
    size.height - 5,
  );
  path.lineTo(size.width - 20, size.height + 13);
  // Right decoration 4
  path.quadraticBezierTo(
    size.width - 7,
    size.height + 10,
    size.width - 5,
    size.height + 6,
  );
  // Go to left
  path.quadraticBezierTo(size.width / 2, size.height + 3, 5, size.height + 7);
  // Left decoration 4
  path.quadraticBezierTo(7, size.height + 10, 20, size.height + 13);
  // path.lineTo(18.5, size.height + 10.5);
  path.lineTo(2, size.height - 5);
  // Left decoration 3
  path.quadraticBezierTo(-5, size.height - 12, 5, size.height - 15);
  // Left decoration 2
  path.quadraticBezierTo(2, size.height / 1.5, 0, 30);
  // Left decoration 1
  path.quadraticBezierTo(7, 30, 2, 7);
  path.close();
  return path;
}

Path widgetPath(Size size) {
  Path path = Path();
  // Top Left Thing
  path.moveTo(2, 7);
  path.quadraticBezierTo(10, 7, 7, 1);
  // Top Right Thing
  path.lineTo(size.width - 7, 1);
  path.quadraticBezierTo(size.width - 10, 7, size.width - 2, 7);
  // Middle Right
  path.lineTo(size.width, 20);
  // Bottom Right Thing
  path.quadraticBezierTo(
    size.width - 7,
    size.height / 3,
    size.width,
    size.height,
  );
  // Bottom Left
  path.lineTo(0, size.height);
  // Bottom Left to Middle
  path.quadraticBezierTo(7, size.height / 3, 0, 20);
  path.close();
  return path;
}

class AbilityWidgetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.black;
    Path path = widgetPath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AbilityWidgetDecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.grey[700];
    Path path = decorationPath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AbilityWidgetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => widgetPath(size);
  @override
  bool shouldReclip(AbilityWidgetClipper oldClipper) => false;
}

class AbilityModifier extends StatelessWidget {
  final String name;
  final int value;
  final bool proficient;

  const AbilityModifier({
    Key key,
    @required this.name,
    @required this.value,
    @required this.proficient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 75,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: AbilityWidgetClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: proficient
                    ? Color.fromRGBO(204, 195, 181, 1)
                    : Color.fromRGBO(244, 235, 221, 1),
              ),
              alignment: Alignment(0, 0),
              child: Column(
                children: <Widget>[
                  this._buildName(),
                  this._buildValue(),
                ],
              ),
            ),
          ),
          CustomPaint(
            painter: AbilityWidgetDecorationPainter(),
            child: Container(height: 80),
          ),
          CustomPaint(
            painter: AbilityWidgetPainter(),
            child: Container(height: 80),
          ),
        ],
      ),
    );
  }

  Widget _buildValue() {
    int value = (this.value * 0.5 - 5).floor();
    return Text(
      "$value",
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildName() {
    return Text(
      "${this.name}",
      style: TextStyle(fontWeight: FontWeight.w600),
    );
  }
}
