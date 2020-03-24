import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      primary: true,
      backgroundColor: Color(0xFFe0d7c9),
      elevation: 0,
      title: Center(
        child: Text("D&D App", style: TextStyle(color: Colors.black)),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
