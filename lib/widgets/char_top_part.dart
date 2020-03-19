import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/char_btn.dart';
import 'package:dnd/widgets/health_bar.dart';
import 'package:flutter/material.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 14,
  fontFamily: 'Cinzel',
);

class TopPart extends StatelessWidget {
  const TopPart({Key key, @required this.char}) : super(key: key);

  final Character char;

  Widget buildAvatar({String name}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 75,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset("assets/images/bard.jpg"),
          ),
          Text(name, style: _textStyle),
          Text("LV. ${char.level}", style: _textStyle),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildAvatar(name: char.name),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${char.race} ${char.charClass} - ${char.alignment}",
                  style: _textStyle),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "${char.curHealth + char.healing} / ${char.maxHealth}",
                          style: _textStyle,
                        ),
                        LinearHealthProgressIndicator(
                          maxHealth: char.maxHealth,
                          curHealth: char.curHealth,
                          healing: char.healing,
                        ),
                      ],
                    ),
                  ),
                  // Vertical Divider
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey,
                      height: 25,
                      width: 1,
                    ),
                  ),
                  Text("${char.curHealth} + ${char.healing}",
                      style: _textStyle),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CharButton(
                    text: "Damage",
                  ),
                  CharButton(
                    text: "Heal",
                  ),
                  CharButton(
                    text: "Add Temp",
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
