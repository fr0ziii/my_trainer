import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String title;
  final DateTime date;
  final String description;
  final String userId; // ID del usuario que creó el evento
  final String trainerId; // ID del entrenador
  final List<String> studentIds; // IDs de los alumnos apuntados
  final Duration duration; // Duración del evento

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.userId,
    required this.trainerId,
    required this.studentIds,
    required this.duration,
  });

  // Convert EventModel to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'description': description,
      'userId': userId,
      'trainerId': trainerId,
      'studentIds': studentIds,
      'duration': duration.inMinutes, // Guardar la duración en minutos
    };
  }

  // Create an EventModel from a map
  factory EventModel.fromMap(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? '',
      title: json['title'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      userId: json['userId'],
      trainerId: json['trainerId'],
      studentIds: List<String>.from(json['studentIds'] ?? []),
      duration: Duration(minutes: json['duration']),
    );
  }

  // Create an EventModel from a Firestore document
  factory EventModel.fromDocument(DocumentSnapshot doc) {
    return EventModel.fromMap(doc.data() as Map<String, dynamic>);
  }
}
