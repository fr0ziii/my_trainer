import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_trainer/models/user_model.dart';
import 'package:my_trainer/services/auth_service.dart';
import 'package:my_trainer/services/firestore_service.dart';
import 'package:my_trainer/services/user_service.dart';

class MockFirestoreService extends Mock implements FirestoreService {
  void main() {
    const collection = 'tests';
    group('FirestoreService', () {
      test('addDocument', () async {
        final firestoreService = FirestoreService();
        final mockFirestore = MockFirestoreService();
        when(mockFirestore.addDocument(collection, {'id': 'id'})).thenAnswer((_) async {});
        await firestoreService.addDocument('collection', {});
        verify(mockFirestore.addDocument('collection', {}));
      });

      test('getDocument', () async {
        final firestoreService = FirestoreService();        final mockFirestore = MockFirestoreService();
        when(mockFirestore.getDoc(collection, 'id')).thenAnswer((_) async {});
        await firestoreService.getDocument('collection', 'id');
        verify(mockFirestore.getDocument('collection', 'id'));
      });

      test('updateDocument', () async {
        final firestoreService = FirestoreService();
        final mockFirestore = MockFirestoreService();
        when(mockFirestore.updateDocument(collection, 'id', {'id': 'id'})).thenAnswer((_) async {});
        await firestoreService.updateDocument('collection', 'id', {});
        verify(mockFirestore.updateDocument('collection', 'id', {}));
      });

      test('deleteDocument', () async {
        final firestoreService = FirestoreService();
        final mockFirestore = MockFirestoreService();
        when(mockFirestore.deleteDocument(collection, 'id')).thenAnswer((_) async {});
        await firestoreService.deleteDocument('collection', 'id');
        verify(mockFirestore.deleteDocument('collection', 'id'));
      });

      test('setDocument', () async {
        final firestoreService = FirestoreService();
        final mockFirestore = MockFirestoreService();
        when(mockFirestore.setDocument(collection, 'id', {'id': 'id'})).thenAnswer((_) async {});
        await firestoreService.setDocument('collection', 'id', {});
        verify(mockFirestore.setDocument('collection', 'id', {}));
      });

      test('getDocumentOfCollection', () async {
        final firestoreService = FirestoreService();
        final mockFirestore = MockFirestoreService();
        when(mockFirestore.getDocumentOfCollection(collection)).thenAnswer((_) async {});
        await firestoreService.getDocumentOfCollection('collection');
        verify(mockFirestore.getDocumentOfCollection('collection'));
      });
    });
  }
}

class MockUserService extends Mock implements UserService {
  Future<UserModel> getUserModel(String uid) async {
    return UserModel(
      uid: 'uid',
      displayName: 'displayName',
      email: 'email',
      role: 'role',
      profilePictureUrl: 'profilePictureUrl',
      stripeCustomerId: '',
      trainerId: '',
    );
  }
}

class MockAuthService extends Mock implements AuthService {
  Future<UserModel> getCurrentUser() async {
    return UserModel(
      uid: 'uid',
      displayName: 'displayName',
      email: 'email',
      role: 'role',
      profilePictureUrl: 'profilePictureUrl',
      stripeCustomerId: '',
      trainerId: '',
    );
  }
}