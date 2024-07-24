import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_model.dart';
import 'firestore_service.dart';

class EventService {
  final FirestoreService _firestoreService = FirestoreService();
  final String _collectionPath = 'events';

  Future<void> createEvent(EventModel event) async {
    await _firestoreService.addDocument(_collectionPath, event.toMap());
  }

  Future<EventModel> getEvent(String id) async {
    final DocumentSnapshot doc =
        await _firestoreService.getDocument(_collectionPath, id);
    return EventModel.fromDocument(doc);
  }

  Future<void> updateEvent(EventModel event) async {
    await _firestoreService.updateDocument(_collectionPath, event.id, event.toMap());
  }

  Future<void> deleteEvent(String id) async {
    await _firestoreService.deleteDocument(_collectionPath, id);
  }

  Future<void> setEvent(EventModel event) async {
    await _firestoreService.setDocument(_collectionPath, event.id, event.toMap());
  }

  Stream<List<EventModel>> getEvents() {
    return FirebaseFirestore.instance.collection(_collectionPath).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => EventModel.fromDocument(doc)).toList();
    });
  }

  Stream<List<EventModel>> getEventsByTrainer(String id) {
    return FirebaseFirestore.instance.collection(_collectionPath).where('trainerId', isEqualTo: id).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => EventModel.fromDocument(doc)).toList();
    });
  }
}
