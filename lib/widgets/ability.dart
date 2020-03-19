import 'package:flutter/material.dart';

Path makePath(Size size) {
  Path path = Path();
  path.moveTo(0, 10);
  var firstControlPoint = new Offset(10, 10);
  var firstEndPoint = new Offset(10, 1);
  path.quadraticBezierTo(
    firstControlPoint.dx,
    firstControlPoint.dy,
    firstEndPoint.dx,
    firstEndPoint.dy,
  );
  path.lineTo(size.width - 10, 1);
  var secondControlPoint = new Offset(size.width - 10, 10);
  var secondEndPoint = new Offset(size.width, 10);
  path.quadraticBezierTo(
    secondControlPoint.dx,
    secondControlPoint.dy,
    secondEndPoint.dx,
    secondEndPoint.dy,
  );
  path.lineTo(size.width, size.height);
  path.lineTo(0, size.height);
  path.close();
  return path;
}

class CustomBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;
    Path path = makePath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CustomRect extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => makePath(size);
  @override
  bool shouldReclip(CustomRect oldClipper) => false;
}

class AbilityWidget extends StatelessWidget {
  const AbilityWidget({
    Key key,
    @required this.name,
    @required this.value,
    @required this.mod,
  }) : super(key: key);

  final String name;
  final int value;
  final int mod;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4, right: 4),
      height: 100,
      child: Stack(
        children: <Widget>[
          ModAbility(name: name, mod: mod),
          ValueAbility(value: value)
        ],
      ),
    );
  }
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
            painter: CustomBorderPainter(),
            child: Container(height: 100),
          ),
          ClipPath(
            clipper: CustomRect(),
            child: Material(
              child: MaterialButton(
                child: Column(
                  children: <Widget>[
                    Text(
                      "${this.name}",
                      style: TextStyle(fontFamily: 'Cinzel'),
                    ),
                    Text(
                      "${this.mod}",
                      style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Sacramento',
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  print("Changing Mod Ability");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
      bottom: 1,
      child: GestureDetector(
        onTap: () {
          print("Changing Ability");
        },
        child: Container(
          alignment: Alignment(0, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: new Border.all(width: 1, color: Colors.black),
          ),
          child: Text(
            "${this.value}",
            style: TextStyle(color: Colors.black, fontFamily: 'Sacramento'),
          ),
          height: 40,
          width: 60,
        ),
      ),
    );
  }
}
