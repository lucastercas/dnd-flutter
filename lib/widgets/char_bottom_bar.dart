// import 'package:dnd/models/char.dart';
// import 'package:dnd/services/json_parser.dart';
// import 'package:flutter/material.dart';

// class DiamondClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(size.width / 2, 0);
//     path.lineTo(size.width, size.height / 2);
//     path.lineTo(size.width / 2, size.height);
//     path.lineTo(0, size.height / 2);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(DiamondClipper oldClipper) => false;
// }

// class CharacterScreenBottomBar extends StatelessWidget {
//   const CharacterScreenBottomBar({Key key, this.char}) : super(key: key);

//   final Character char;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//       height: 60,
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             flex: 1,
//             child: Container(
//               alignment: Alignment(0, 0),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.red,
//               ),
//               child: Text("oi"),
//             ),
//           ),
//           MagicSlots(char: char),
//         ],
//       ),
//     );
//   }
// }

// class MagicSlots extends StatelessWidget {
//   const MagicSlots({
//     Key key,
//     @required this.char,
//   }) : super(key: key);

//   final Character char;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: parseJson("assets/spells.json"),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         Map<String, dynamic> spells = snapshot.data;
//         if (spells == null) return CircularProgressIndicator();
//         return Expanded(
//           flex: 4,
//           child: Container(
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: char.spells["slots"].length,
//               itemBuilder: (BuildContext context, int index) {
//                 String key = char.spells["slots"].keys.elementAt(index);
//                 var curSlot = char.spells["slots"][key];
//                 return MagicSlotDiamond(
//                   used: curSlot["used"],
//                   image: spells[key]["image"],
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class MagicSlotDiamond extends StatelessWidget {
//   const MagicSlotDiamond({
//     Key key,
//     @required this.used,
//     @required this.image,
//   }) : super(key: key);

//   final bool used;
//   final String image;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 8, bottom: 8, left: 2, right: 2),
//       child: GestureDetector(
//         onTap: () {},
//         child: ClipPath(
//           clipper: DiamondClipper(),
//           child: Container(
//             alignment: Alignment(0, 0),
//             height: 50,
//             width: 50,
//             color: used ? Colors.grey : Colors.blueGrey[500],
//             child: Text(
//               image,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.white,
//                 fontFamily: 'Great Vibes'
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
