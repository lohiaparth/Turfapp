import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { player, owner }

class UserModel {
  final String uid;
  final String fullname;
  final String email;
  final String phone;
  final UserRole role;

  const UserModel({
    required this.uid,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.role,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      fullname: data['fullname'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      role: data['role'] == 'owner' ? UserRole.owner : UserRole.player,
    );
  }

  Map<String, dynamic> toMap() => {
        'fullname': fullname,
        'email': email,
        'phone': phone,
        'role': role == UserRole.owner ? 'owner' : 'player',
      };

  UserModel copyWith({
    String? uid,
    String? fullname,
    String? email,
    String? phone,
    UserRole? role,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
    );
  }
}
