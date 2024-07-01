import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String title;
  final String? description;
  final String sessionType;
  final DateTime sessionDate;
  final DateTime startTime;
  final DateTime endTime;
  final int capacity;
  final String userId; // ID del usuario que creó el evento
  final String trainerId; // ID del entrenador
  final List<String> clientsIds; // IDs de los alumnos apuntados


  EventModel({
    required this.id,
    required this.title,
    this.description,
    required this.sessionType,
    required this.sessionDate,
    required this.startTime,
    required this.endTime,
    required this.capacity,
    required this.userId,
    required this.trainerId,
    required this.clientsIds,
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
      'capacity': capacity,
      'description': description ?? '',
      'userId': userId,
      'trainerId': trainerId,
      'studentIds': clientsIds, // Guardar la duración en minutos
    };
  }

  // Create an EventModel from a map
  factory EventModel.fromMap(Map<String, dynamic> json) {
    return EventModel(
        id: json['id'],
        title: json['title'],
        sessionDate: json['date'],
        sessionType: json['sessionType'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        capacity: json['capacity'],
        description: json['description'] ?? '',
        userId: json['userId'],
        trainerId: json['trainerId'],
        clientsIds: List<String>.from(json['clientsIds'] ?? []));

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
