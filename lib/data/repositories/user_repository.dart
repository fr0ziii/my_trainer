import 'package:my_trainer/data/repositories/firestore.dart';

class UserRepository {
  Future<void> addUser(String id, Map<String, dynamic> userData) async {
    await FirestoreRepository().setDocument('users', id, userData);
  }
}
