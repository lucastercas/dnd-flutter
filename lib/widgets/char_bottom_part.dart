import 'package:flutter/material.dart';
import 'package:dnd/models/char.dart';

class CustomRect extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 10);

    var firstControlPoint = new Offset(10, 10);
    var firstEndPoint = new Offset(10, 0);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    path.lineTo(size.width - 10, 0);
    var secondControlPoint = new Offset(size.width - 10, 10);
    var secondEndPoint = new Offset(size.width, 10);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(size.width - 15, size.height);
    var thirdControlPoint = new Offset(size.width / 2, size.height - 20);
    var thirdEndPoint = new Offset(15, size.height);
    path.quadraticBezierTo(
      thirdControlPoint.dx,
      thirdControlPoint.dy,
      thirdEndPoint.dx,
      thirdEndPoint.dy,
    );

    path.lineTo(0, size.height);
    path.close();
    return path;
  }

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
      height: 100,
      child: Stack(
        children: <Widget>[
          Container(
            height: 80,
            child: Positioned(
              child: ClipPath(
                clipper: CustomRect(),
                child: Material(
                  child: MaterialButton(
                    child: Column(
                      children: <Widget>[
                        Text("${this.name}",
                            style: TextStyle(fontFamily: 'Cinzel')),
                        Text("${this.value}", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 17,
            bottom: 3,
            child: ClipOval(
              child: Container(
                alignment: Alignment(0, 0),
                color: Colors.red,
                child: Text("${this.mod}"),
                height: 25,
                width: 55,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BottomPart extends StatelessWidget {
  const BottomPart({Key key, @required this.char}) : super(key: key);

  final Character char;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AbilityWidget(
                value: 10,
                mod: 2,
                name: "Str",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
