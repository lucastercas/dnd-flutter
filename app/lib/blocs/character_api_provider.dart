import 'package:dnd/models/character.dart';
import 'package:dnd/services/json_parser.dart';
import 'package:flutter/material.dart';

class CharacterApiProvider {

  Future<Character> fetchCharacterFromJson({
    @required String filePath,
    @required String charName,
  }) async {
    Map<String, dynamic> data = await parseJson(filePath);
    Character character = Character.fromJson(data[charName]);
    return character;
  }

  Future<List<Character>> fetchCharactersFromJson({
    @required String filePath,
  }) async {
    Map<String, dynamic> data = await parseJson(filePath);
    Map<String, dynamic> characters = data['characters'];
    List<Character> chars = List<Character>();
    characters.forEach((key, value) {
      chars.add(Character.fromJson(value));
    });
    return chars;
  }
}