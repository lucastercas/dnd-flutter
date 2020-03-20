import 'package:dnd/models/char.dart';
import 'package:dnd/widgets/black_button.dart';
import 'package:dnd/widgets/character_armour.dart';
import 'package:dnd/widgets/health_bar.dart';
import 'package:dnd/widgets/vertical_divider.dart';
import 'package:flutter/material.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 14,
);

class CharacterStatus extends StatefulWidget {
  const CharacterStatus({
    Key key,
    @required this.char,
    @required this.expanded,
  }) : super(key: key);

  final Character char;
  final bool expanded;

  @override
  _CharacterStatusState createState() => _CharacterStatusState();
}

class _CharacterStatusState extends State<CharacterStatus> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // Avatar, name and lvl part
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.expanded
                  ? _buildAvatarImage(name: widget.char.name)
                  : Container(),
              widget.expanded ? _buildNameLevel() : Container(),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Race, class and alignment
            widget.expanded
                ? Text(
                    "${widget.char.race} ${widget.char.charClass} - ${widget.char.alignment}",
                    style: _textStyle,
                  )
                : Container(height: 0,),
            Divider(color: Colors.black, height: widget.expanded ? 3 : 0,),
            _buildHealth(),
            Divider(color: Colors.black, height: widget.expanded ? 3 : 1,),
            // Buttons
            _buildButtons(),
          ],
        ),
      ],
    );
  }

  Row _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        BlackButton(text: "Damage"),
        BlackButton(text: "Heal"),
        BlackButton(text: "Add Temp"),
      ],
    );
  }

  Row _buildHealth() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        widget.expanded ? Container() : _buildNameLevel(),
        // Health
        Flexible(
          fit: FlexFit.loose,
          child: Column(
            children: <Widget>[
              Text(
                "${widget.char.curHealth + widget.char.healing} / ${widget.char.maxHealth}",
                style: _textStyle,
              ),
              Container(
                width: 230,
                child: LinearHealthProgressIndicator(
                  maxHealth: widget.char.maxHealth,
                  curHealth: widget.char.curHealth,
                  healing: widget.char.healing,
                ),
              ),
            ],
          ),
        ),
        MyVerticalDivider(),
        // Armour
        Armour(
          armourValue: widget.char.armour,
        )
      ],
    );
  }

  Widget _buildAvatarImage({String name}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 75,
        height: 90,
        child: Image.asset("assets/images/bard.jpg", fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildNameLevel() {
    return Column(
      children: <Widget>[
        Text(widget.char.name, style: _textStyle),
        Text("LV. ${widget.char.level}", style: _textStyle),
      ],
    );
  }
}
