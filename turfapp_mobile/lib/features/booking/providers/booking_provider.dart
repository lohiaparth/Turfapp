import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/booking_model.dart';
import '../../../features/auth/providers/auth_provider.dart';

// ── Booked slots for a turf/date ─────────────────────────────────────────────
final bookedSlotsProvider =
    StreamProvider.family<List<BookingSlot>, ({String turfId, String date})>(
  (ref, args) {
    return FirebaseFirestore.instance
        .collection('bookings')
        .where('turfId', isEqualTo: args.turfId)
        .where('date', isEqualTo: args.date)
        .where('status', isEqualTo: 'confirmed')
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => BookingModel.fromFirestore(d).slot)
            .toList());
  },
);

// ── Player's bookings ─────────────────────────────────────────────────────────
final myBookingsProvider = StreamProvider<List<BookingModel>>((ref) {
  final authState = ref.watch(authStateProvider);
  final uid = authState.valueOrNull?.uid;
  if (uid == null) return Stream.value([]);

  return FirebaseFirestore.instance
      .collection('bookings')
      .where('playerUid', isEqualTo: uid)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) =>
          snap.docs.map((d) => BookingModel.fromFirestore(d)).toList());
});

// ── Owner's bookings for a specific turf ─────────────────────────────────────
final ownerTurfBookingsProvider =
    StreamProvider.family<List<BookingModel>, String>((ref, turfId) {
  return FirebaseFirestore.instance
      .collection('bookings')
      .where('turfId', isEqualTo: turfId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) =>
          snap.docs.map((d) => BookingModel.fromFirestore(d)).toList());
});

// ── Booking notifier ────────────────────────────────────────────────────────
class BookingNotifier extends StateNotifier<AsyncValue<void>> {
  final FirebaseFirestore _db;
  BookingNotifier(this._db) : super(const AsyncValue.data(null));

  Future<bool> createBooking(BookingModel booking) async {
    state = const AsyncValue.loading();
    try {
      await _db.collection('bookings').add(booking.toMap());
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> cancelBooking(String bookingId) async {
    state = const AsyncValue.loading();
    try {
      await _db.collection('bookings').doc(bookingId).update({
        'status': 'cancelled',
      });
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

final bookingNotifierProvider =
    StateNotifierProvider<BookingNotifier, AsyncValue<void>>(
  (ref) => BookingNotifier(FirebaseFirestore.instance),
);
