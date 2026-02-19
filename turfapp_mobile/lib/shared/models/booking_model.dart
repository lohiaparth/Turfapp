import 'package:cloud_firestore/cloud_firestore.dart';

enum BookingSlot { morning, afternoon, evening, night }

extension BookingSlotExtension on BookingSlot {
  String get label {
    switch (this) {
      case BookingSlot.morning:
        return 'Morning';
      case BookingSlot.afternoon:
        return 'Afternoon';
      case BookingSlot.evening:
        return 'Evening';
      case BookingSlot.night:
        return 'Night';
    }
  }

  String get timeRange {
    switch (this) {
      case BookingSlot.morning:
        return '6:00 AM – 12:00 PM';
      case BookingSlot.afternoon:
        return '12:00 PM – 4:00 PM';
      case BookingSlot.evening:
        return '4:00 PM – 8:00 PM';
      case BookingSlot.night:
        return '8:00 PM – 3:00 AM';
    }
  }

  String get key => name;

  static BookingSlot fromKey(String key) {
    return BookingSlot.values.firstWhere(
      (s) => s.name == key,
      orElse: () => BookingSlot.morning,
    );
  }
}

enum BookingStatus { confirmed, cancelled }

class BookingModel {
  final String id;
  final String turfId;
  final String turfName;
  final String playerUid;
  final String playerName;
  final String date; // ISO date string yyyy-MM-dd
  final BookingSlot slot;
  final BookingStatus status;
  final double totalPrice;
  final DateTime createdAt;

  const BookingModel({
    required this.id,
    required this.turfId,
    required this.turfName,
    required this.playerUid,
    required this.playerName,
    required this.date,
    required this.slot,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
  });

  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      id: doc.id,
      turfId: data['turfId'] ?? '',
      turfName: data['turfName'] ?? '',
      playerUid: data['playerUid'] ?? '',
      playerName: data['playerName'] ?? '',
      date: data['date'] ?? '',
      slot: BookingSlotExtension.fromKey(data['slot'] ?? 'morning'),
      status: data['status'] == 'cancelled'
          ? BookingStatus.cancelled
          : BookingStatus.confirmed,
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'turfId': turfId,
        'turfName': turfName,
        'playerUid': playerUid,
        'playerName': playerName,
        'date': date,
        'slot': slot.key,
        'status': status == BookingStatus.cancelled ? 'cancelled' : 'confirmed',
        'totalPrice': totalPrice,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}
