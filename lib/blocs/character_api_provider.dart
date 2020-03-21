import 'package:dnd/models/char.dart';
import 'package:dnd/services/json_parser.dart';
import 'package:flutter/material.dart';

class CharacterApiProvider {
  Future<Character> fetchCharacter({
    @required String filePath,
    @required String charName,
  }) async {
    print("Getting Character $charName");
    Map<String, dynamic> data = await parseJson(filePath);
    Character char = Character.fromJson(data[charName]);
    return char;
  }

  Future<List<Character>> fetchCharacters({
    @required String filePath,
  }) async {
    Map<String, dynamic> data = await parseJson(filePath);
    List<Character> chars = List<Character>();
    data.forEach((key, value) {
      chars.add(Character.fromJson(value));
    });
    return chars;
  }
}
