// import 'package:dnd/blocs/add_character/bloc.dart';
// import 'package:dnd/services/storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SelectAvatar extends StatefulWidget {
//   final BuildContext context;
//   const SelectAvatar({Key key, @required this.context}) : super(key: key);

//   @override
//   _SelectAvatarState createState() => _SelectAvatarState();
// }

// class _SelectAvatarState extends State<SelectAvatar> {
//   int _imageChoosen = 0;
//   AddCharacterBloc _addCharacterBloc;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _addCharacterBloc = BlocProvider.of<AddCharacterBloc>(widget.context);

//     return FutureBuilder(
//       future: _storageProvider.getAvatars(),
//       builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
//         return AlertDialog(
//           title: Text("Choose an avatar"),
//           content: snapshot.hasData
//               ? ListView.builder(
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (context, index) {
//                     String path = snapshot.data.keys.elementAt(index);
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
//                       child: MaterialButton(
//                         onPressed: () {
//                           setState(() {
//                             _imageChoosen = index;
//                           });
//                         },
//                         child: ,
//                       ),
//                     );
//                   },
//                 )
//               : ,
//           actions: <Widget>[
//             FlatButton(
//               child: Text("Cancel"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             FlatButton(child: Text("Select"), onPressed: () {})
//           ],
//         );
//       },
//     );
//   }
// }
