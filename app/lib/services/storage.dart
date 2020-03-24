import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd/services/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageProvider {
  final _storage = FirebaseStorage.instance.ref();
  final _firestore = FirestoreProvider();

  void uploadImage(String path, var data) {
    final StorageReference ref = _storage.child(path);
    final StorageUploadTask uploadTask = ref.putFile(data);
    var test = uploadTask.onComplete;
  }

  Future<Map<String, String>> getAvatars() async {
    print("Getting Images");
    DocumentReference docRef = _firestore.getDocumentReference(
      "images",
      "avatars",
    );
    DocumentSnapshot avatarsDocSnap = await docRef.get();
    Map<String, dynamic> data = avatarsDocSnap.data;
    List<dynamic> avatarPaths = data["paths"];
    Map<String, String> urls = {};
    for (String imageName in avatarPaths) {
      String path = "avatars/$imageName";
      StorageReference image = _storage.child(path);
      urls[path] = await image.getDownloadURL();
    }
    return urls;
  }
}
