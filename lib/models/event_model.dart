import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final String sessionType;
  final String sessionDate;
  final String startTime;
  final String endTime;
  final String userId; // ID del usuario que creó el evento
  final String trainerId; // ID del entrenador
  final List<String> studentIds; // IDs de los alumnos apuntados
  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.sessionType,
    required this.sessionDate,
    required this.startTime,
    required this.endTime,
    required this.userId,
    required this.trainerId,
    required this.studentIds,
  });

  // Convert EventModel to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': sessionDate,
      'sessionType': sessionType,
      'startTime': startTime,
      'endTime': endTime,
      'description': description,
      'userId': userId,
      'trainerId': trainerId,
      'studentIds': studentIds, // Guardar la duración en minutos
    };
  }

  // Create an EventModel from a map
  factory EventModel.fromMap(Map<String, dynamic> json) {
    return EventModel(
        id: json['id'] ?? '',
        title: json['title'],
        sessionDate: json['date'],
        sessionType: json['sessionType'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        description: json['description'],
        userId: json['userId'],
        trainerId: json['trainerId'],
        studentIds: List<String>.from(json['studentIds'] ?? []));
  }

  // Create an EventModel from a Firestore document
  factory EventModel.fromDocument(DocumentSnapshot doc) {
    return EventModel.fromMap(doc.data() as Map<String, dynamic>);
  }
}

final List<String> sessionTypes = [
  'Fisioterapia',
  'Entrenamiento personal',
  'Crossfit',
  'Yoga',
  'Boxeo',
];
