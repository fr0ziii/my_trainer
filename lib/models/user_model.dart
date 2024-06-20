import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String role;
  final String? profilePictureUrl;
  final DateTime registrationDate;
  final String? trainerId; // ID del entrenador (para clientes)
  final List<String>? clientIds; // IDs de los clientes (para entrenadores)
  final String? invitationCode; // Código de invitación (para entrenadores)
  final int? availableSlots; // Número de plazas disponibles (para entrenadores)
  final List<String>? sessionIds; // IDs de las sesiones (para entrenadores)

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
    this.profilePictureUrl,
    required this.registrationDate,
    this.trainerId,
    this.clientIds,
    this.invitationCode,
    this.availableSlots,
    this.sessionIds,
  });

  // Convert UserModel to a map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'role': role,
      'profilePictureUrl': profilePictureUrl,
      'registrationDate': registrationDate.toIso8601String(),
      'trainerId': trainerId,
      'clientIds': clientIds,
      'invitationCode': invitationCode,
      'availableSlots': availableSlots,
      'sessionIds': sessionIds,
    };
  }

  // Create a UserModel from a map
  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'],
      displayName: json['displayName'],
      role: json['role'],
      profilePictureUrl: json['profilePictureUrl'],
      registrationDate: DateTime.parse(json['registrationDate']),
      trainerId: json['trainerId'],
      clientIds: List<String>.from(json['clientIds'] ?? []),
      invitationCode: json['invitationCode'],
      availableSlots: json['availableSlots'],
      sessionIds: List<String>.from(json['sessionIds'] ?? []),
    );
  }

  // Create a UserModel from a Firestore document
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }
}
