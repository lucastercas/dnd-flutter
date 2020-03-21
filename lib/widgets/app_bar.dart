import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget  with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(244, 235, 221, 1000),
      title: Center(
        child: Text(
          "D&D App Mockup",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
