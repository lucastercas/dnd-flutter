import 'package:dnd/models/char.dart';
import 'package:dnd/services/json_parser.dart';

class CharacterApiProvider {

  Future<Character> fetchCharacter({String filePath}) async {
    Map<String, dynamic> data = await parseJson(filePath);
    Character char = Character.fromJson(data);
    return char;
  }
}
