import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    await _firestore.collection(collection).add(data);
  }

  Future<DocumentSnapshot> getDocument(String collection, String id) async {
    return await _firestore.collection(collection).doc(id).get();
  }

  Future<void> updateDocument(
      String collection, String id, Map<String, dynamic> data) async {
    await _firestore.collection(collection).doc(id).update(data);
  }

  Future<void> deleteDocument(String collection, String id) async {
    await _firestore.collection(collection).doc(id).delete();
  }

  Future<void> setDocument(
      String collection, String id, Map<String, dynamic> data) async {
    await _firestore.collection(collection).doc(id).set(data);
  }

  Future<void> getDocumentOfCollection(String collection) async {
    await _firestore.collection(collection).get();
  }
}
