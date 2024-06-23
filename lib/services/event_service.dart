import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/event_model.dart';
import 'firestore_service.dart';

class EventService {
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> createEvent(EventModel event) async {
    await _firestoreService.addDocument('events', event.toMap());
  }

  Future<EventModel> getEvent(String id) async {
    final DocumentSnapshot doc =
        await _firestoreService.getDocument('events', id);
    return EventModel.fromDocument(doc);
  }

  Future<void> updateEvent(EventModel event) async {
    await _firestoreService.updateDocument('events', event.id, event.toMap());
  }

  Future<void> deleteEvent(String id) async {
    await _firestoreService.deleteDocument('events', id);
  }

  Future<void> setEvent(EventModel event) async {
    await _firestoreService.setDocument('events', event.id, event.toMap());
  }

  Stream<List<EventModel>> getEvents() {
    return FirebaseFirestore.instance.collection("events").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => EventModel.fromDocument(doc)).toList();
    });
  }
}
