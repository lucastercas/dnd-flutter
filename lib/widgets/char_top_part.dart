import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/char_btn.dart';
import 'package:dnd/widgets/health_bar.dart';
import 'package:flutter/material.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 15,
);

class TopPart extends StatelessWidget {
  const TopPart({Key key, @required this.char}) : super(key: key);

  final Character char;

  Padding buildAvatar({String name}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
            child: Image.asset(
              "assets/images/bard.jpg",
              // width: 100,
              // height: 120,
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontFamily: 'Cinzel',
            ),
          ),
          Text(
            "LV. ${char.level}",
            style: TextStyle(
              fontFamily: 'Cinzel',
            ),
          ),
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
              Text(
                "${char.race} - ${char.charClass}",
                style: _textStyle,
              ),
              Divider(),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                            "${char.curHealth + char.healing} / ${char.maxHealth}"),
                        Container(
                          height: 17,
                          child: LinearHealthProgressIndicator(
                            maxHealth: char.maxHealth,
                            curHealth: char.curHealth,
                            healing: char.healing,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey,
                      height: 25,
                      width: 1,
                    ),
                  ),
                  Text(
                    "${char.curHealth} + ${char.healing}",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
