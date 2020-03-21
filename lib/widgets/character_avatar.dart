import 'package:flutter/material.dart';

class CharacterAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 75,
        height: 90,
        child: Image.asset(
          "assets/images/bard.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
