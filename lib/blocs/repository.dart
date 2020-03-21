import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd/models/char.dart';
import 'package:dnd/blocs/character_api_provider.dart';
import 'package:dnd/services/cloud_firestore.dart';

class CharacterRepository {
  final FirestoreProvider _firestoreProvider = FirestoreProvider();
  CharacterApiProvider _charApiProvider = CharacterApiProvider();

  Stream<DocumentSnapshot> getCharacter(String charName) {
    return _firestoreProvider.getDocumentStream("characters", charName);
  }

  Stream<List<Character>> getCharacters() {
    var transformer =
        StreamTransformer<QuerySnapshot, List<Character>>.fromHandlers(
            handleData: (
      QuerySnapshot docs,
      EventSink sink,
    ) {
      List<Character> chars = List<Character>();
      docs.documents.forEach((DocumentSnapshot doc) {
        chars.add(Character.fromSnapshot(doc));
      });
      sink.add(chars);
    });
    return _firestoreProvider
        .getCollectionStream("characters")
        .transform(transformer);
  }

  Future<Character> fetchCharacterFromJson(String filePath, String charName) {
    return _charApiProvider.fetchCharacterFromJson(
      filePath: filePath,
      charName: charName,
    );
  }

  Future<List<Character>> fetchCharactersFromJson(String filePath) {
    return _charApiProvider.fetchCharactersFromJson(
      filePath: filePath,
    );
  }
}
