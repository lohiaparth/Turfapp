import 'package:cloud_firestore/cloud_firestore.dart';

class TurfModel {
  final String id;
  final String name;
  final String address;
  final String ownerUid;
  final String contact1;
  final String? contact2;
  final List<String> sports;
  final double pricePerSlot;
  final List<String> imageUrls;
  final DateTime createdAt;

  const TurfModel({
    required this.id,
    required this.name,
    required this.address,
    required this.ownerUid,
    required this.contact1,
    this.contact2,
    required this.sports,
    required this.pricePerSlot,
    required this.imageUrls,
    required this.createdAt,
  });

  factory TurfModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TurfModel(
      id: doc.id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      ownerUid: data['ownerUid'] ?? '',
      contact1: data['contact1'] ?? '',
      contact2: data['contact2'],
      sports: List<String>.from(data['sports'] ?? []),
      pricePerSlot: (data['pricePerSlot'] ?? 0).toDouble(),
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'address': address,
        'ownerUid': ownerUid,
        'contact1': contact1,
        if (contact2 != null) 'contact2': contact2,
        'sports': sports,
        'pricePerSlot': pricePerSlot,
        'imageUrls': imageUrls,
        'createdAt': Timestamp.fromDate(createdAt),
      };

  TurfModel copyWith({
    String? id,
    String? name,
    String? address,
    String? ownerUid,
    String? contact1,
    String? contact2,
    List<String>? sports,
    double? pricePerSlot,
    List<String>? imageUrls,
    DateTime? createdAt,
  }) {
    return TurfModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      ownerUid: ownerUid ?? this.ownerUid,
      contact1: contact1 ?? this.contact1,
      contact2: contact2 ?? this.contact2,
      sports: sports ?? this.sports,
      pricePerSlot: pricePerSlot ?? this.pricePerSlot,
      imageUrls: imageUrls ?? this.imageUrls,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
