import '/services/firestore_service.dart';

import '../../models/user_model.dart';

const usersCollections = 'users';

class UserService {
  Future<void> addUser(String id, Map<String, dynamic> userData) async {
    await FirestoreService().setDocument(usersCollections, id, userData);
  }

  Future<UserModel> getUser(String id) async {
    return UserModel.fromDocument(
        await FirestoreService().getDocument(usersCollections, id));
  }

  Future<bool> checkIfUserExists(String id) async {
    var user = await FirestoreService().getDocument(usersCollections, id);
    if (user.exists) {
      return true;
    }
    return false;
  }

  Future<UserModel> getUserModel(String id) async {
    var documentSnapshot = await FirestoreService().getDocument(usersCollections, id);
    return UserModel.fromDocument(documentSnapshot);
  }

}
