import 'package:cloud_firestore/cloud_firestore.dart';

import '/services/firestore_service.dart';

import '../../models/user_model.dart';

const _collectionPath = 'users';

class UserService {
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> addUser(String id, Map<String, dynamic> userData) async {
    await _firestoreService.setDocument(_collectionPath, id, userData);
  }

  Future<UserModel> getUser(String id) async {
    return UserModel.fromDocument(await _firestoreService.getDocument(_collectionPath, id));
  }

  Future<bool> checkIfUserExists(String id) async {
    var user = await _firestoreService.getDocument(_collectionPath, id);
    if (user.exists) {
      return true;
    }
    return false;
  }

  Future<UserModel> getUserModel(String id) async {
    var documentSnapshot = await _firestoreService.getDocument(_collectionPath, id);
    return UserModel.fromDocument(documentSnapshot);
  }

  Stream<List<UserModel>> getUsersByTrainer(String id) {
    return FirebaseFirestore.instance
        .collection(_collectionPath)
        .where('trainerId', isEqualTo: id)
        .where('role', isEqualTo: 'client')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromDocument(doc)).toList();
    });
  }
}
