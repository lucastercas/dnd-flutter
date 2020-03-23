import 'package:firebase_storage/firebase_storage.dart';

class StorageProvider {
  final _storage = FirebaseStorage.instance;

  void uploadImage(String path, var data) {
    final StorageReference ref = _storage.ref().child(path);
    final StorageUploadTask uploadTask = ref.putFile(data);

    //await uploadTask.onComplete;
  }
}
