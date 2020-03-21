import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;
  // const FirestoreProvider(){
    // _firestore = Firestore.instance;
  // }

  Stream<QuerySnapshot> getCollectionStream(String col) {
    return _firestore.collection(col).snapshots();
  }

  Stream<DocumentSnapshot> getDocumentStream(String col, String doc) {
    return _firestore.collection(col).document(doc).snapshots();
  }

  DocumentReference getDocumentReference(String col, String docId) {
    return _firestore.collection(col).document(docId);
  }

  Future<void> addDocument(String col, String name) async {
    DocumentReference doc = await _firestore.collection(col).add({
      'name': name,
      'done': false,
    });
  }
}
/*
  Future<bool> authenticateUser(String email, String password) async {
    final QuerySnapshot result = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();
    final List<DocumentSnapshot> docs = result.documents;
    return docs.length == 0 ? false : true;
  }
*/