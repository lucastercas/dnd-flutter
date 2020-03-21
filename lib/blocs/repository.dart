import 'package:dnd/models/char.dart';
import 'package:dnd/blocs/character_api_provider.dart';

class CharacterRepository {
  Future<Character> fetchCharacter(String filePath) {
    CharacterApiProvider _charApiProvider =
        CharacterApiProvider();
    print("Fetching character - repo");
    return _charApiProvider.fetchCharacter(filePath: filePath);
  }
}
