import 'package:dnd/models/char.dart';
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
    this.char,
  }) : super(key: key);

  final Character char;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      height: 60,
      padding: EdgeInsets.all(8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: char.spells["slots"].length,
        itemBuilder: (BuildContext context, int index) {
          String key = char.spells["slots"].keys.elementAt(index);
          var curSlot = char.spells["slots"][key];
          return MagicSlotDiamond(
            used: curSlot["used"],
            image: key,
          );
        },
      ),
    );
  }
}

class MagicSlotDiamond extends StatelessWidget {
  const MagicSlotDiamond({
    Key key,
    @required this.used,
    @required this.image,
  }) : super(key: key);

  final bool used;
  final String image;

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
          child: Text(image),
        ),
      ),
    );
  }
}
