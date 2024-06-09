import 'package:my_trainer/data/repositories/firestore.dart';

import '../models/user_model.dart';

class UserRepository {
  Future<void> addUser(String id, Map<String, dynamic> userData) async {
    await FirestoreRepository().setDocument('users', id, userData);
  }

  Future<UserModel> getUser(String id) async {
    return UserModel.fromDocument(
        await FirestoreRepository().getDocument('users', id));
  }
}
