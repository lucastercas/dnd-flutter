import 'package:dnd/models/char.dart';
import 'package:dnd/blocs/character_api_provider.dart';

class CharacterRepository {
  CharacterApiProvider _charApiProvider = CharacterApiProvider();

  Future<Character> fetchCharacter(String filePath, String charName) {
    return _charApiProvider.fetchCharacter(
      filePath: filePath,
      charName: charName,
    );
  }

  Future<List<Character>> fetchCharacters(String filePath) {
    return _charApiProvider.fetchCharacters(
      filePath: filePath,
    );
  }
}
