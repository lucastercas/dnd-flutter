import 'package:flutter/material.dart';

class DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(DiamondClipper oldClipper) => false;
}

class CharacterScreenBottomBar extends StatelessWidget {
  const CharacterScreenBottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MagicSlotDiamond(used: true),
          MagicSlotDiamond(used: false)
        ],
      ),
    );
  }
}

class MagicSlotDiamond extends StatelessWidget {
  const MagicSlotDiamond({
    Key key,
    @required this.used,
  }) : super(key: key);

  final bool used;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ClipPath(
        clipper: DiamondClipper(),
        child: Container(
          height: 50,
          width: 50,
          color: used ? Colors.grey : Colors.blueGrey[600],
        ),
      ),
    );
  }
}
