import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String role;
  final String? profilePictureUrl;
  final DateTime? registrationDate;
  final String? trainerId;
  final List<String>? clientIds;
  final String? invitationCode; // Código de invitación
  final int? availableSlots;
  final List<String>? sessionIds;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
    this.profilePictureUrl,
    this.registrationDate,
    this.trainerId,
    this.clientIds,
    this.invitationCode,
    this.availableSlots,
    this.sessionIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'role': role,
      'profilePictureUrl': profilePictureUrl,
      'registrationDate': registrationDate?.toIso8601String(),
      'trainerId': trainerId,
      'clientIds': clientIds,
      'invitationCode': invitationCode,
      'availableSlots': availableSlots,
      'sessionIds': sessionIds,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'],
      displayName: json['displayName'],
      role: json['role'],
      profilePictureUrl: json['profilePictureUrl'],
      registrationDate: json['registrationDate'],
      trainerId: json['trainerId'],
      clientIds: List<String>.from(json['clientIds'] ?? []),
      invitationCode: json['invitationCode'],
      availableSlots: json['availableSlots'],
      sessionIds: List<String>.from(json['sessionIds'] ?? []),
    );
  }

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }
}
