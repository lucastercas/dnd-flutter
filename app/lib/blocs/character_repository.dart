import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd/models/character.dart';
import 'package:dnd/blocs/character_api_provider.dart';
import 'package:dnd/services/cloud_firestore.dart';

class CharacterRepository {
  final FirestoreProvider _firestoreProvider = FirestoreProvider();
  final CharacterApiProvider _charApiProvider = CharacterApiProvider();

  Stream<Character> getCharacter(String characterId) {
    Stream<DocumentSnapshot> doc = _firestoreProvider.getDocumentStream(
      "characters",
      characterId,
    );
    var transformer =
        StreamTransformer<DocumentSnapshot, Character>.fromHandlers(
      handleData: (DocumentSnapshot doc, EventSink sink) {
        Character character = Character.fromSnapshot(doc);
        sink.add(character);
      },
    );
    return doc.transform(transformer);
  }

  Future<Map<String, Character>> getCharacters(String playerUID) async {
    print('Getting Characters');
    Map<String, Character> chars = Map<String, Character>();
    var documents = await _firestoreProvider
        .getCollectionReference("characters")
        .getDocuments();
    documents.documents.forEach((DocumentSnapshot doc) {
      final String id = doc.documentID;
      if (doc["playerUID"] == playerUID)
        chars[id] = Character.fromSnapshot(doc);
    });

    return chars;

    // var transformer =
    //     StreamTransformer<QuerySnapshot, List<Character>>.fromHandlers(
    //   handleData: (QuerySnapshot docs, EventSink sink) {
    //     sink.add(chars);
    //   },
    // );
    // return collection.transform(transformer);
  }

  updateCharacter(
    String charName,
    Map<String, dynamic> data,
  ) async {
    await _firestoreProvider.updateDocument(
      "characters",
      charName,
      data,
    );
  }

  Future addCharacter({Character character}) async {
    await _firestoreProvider.addDocument("characters", "Lucas", {
      "abilities": {
        "str": 0,
        "cha": 0,
        "con": 0,
        "int": 0,
        "wis": 0,
      },
      "alignment": "Chaotic Good",
      "armour": 0,
      "avatar": "female-human-1",
      "class": "Bard",
      "items": [],
      "curHealth": 0,
      "healing": 3,
      "level": 2,
      "maxHealth": 10,
      "name": "Lucas",
      "passivePerception": 16,
      "playerName": "Laura Terças",
      "proficiencies": ["int", "cha"],
      "proficiencyBonus": 2,
      "race": "Human",
      "savingThrows": {
        "Charisma": {"proficient": true, "value": 2},
        "Constitution": {"proficient": true, "value": 2},
        "Dexterity": {"proficient": true, "value": 2},
        "Intelligence": {"proficient": true, "value": 2},
        "Strenght": {"proficient": true, "value": 2},
        "Wisdom": {"proficient": true, "value": 2},
      },
      "skills": {},
      "spells": {},
      "surname": "asdfasdf",
      "tempHealth": 3,
    });
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
