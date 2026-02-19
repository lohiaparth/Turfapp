import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/turf_model.dart';

final turfsStreamProvider = StreamProvider<List<TurfModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('turfs')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map((d) => TurfModel.fromFirestore(d)).toList());
});

// Filter state
class TurfFilter {
  final String query;
  final String? sport; // null = all

  const TurfFilter({this.query = '', this.sport});

  TurfFilter copyWith({String? query, String? sport, bool clearSport = false}) {
    return TurfFilter(
      query: query ?? this.query,
      sport: clearSport ? null : (sport ?? this.sport),
    );
  }
}

final turfFilterProvider = StateProvider<TurfFilter>((_) => const TurfFilter());

final filteredTurfsProvider = Provider<AsyncValue<List<TurfModel>>>((ref) {
  final turfs = ref.watch(turfsStreamProvider);
  final filter = ref.watch(turfFilterProvider);

  return turfs.whenData((list) {
    var result = list;
    if (filter.sport != null) {
      result = result
          .where((t) => t.sports
              .map((s) => s.toLowerCase())
              .contains(filter.sport!.toLowerCase()))
          .toList();
    }
    if (filter.query.isNotEmpty) {
      final q = filter.query.toLowerCase();
      result = result
          .where((t) =>
              t.name.toLowerCase().contains(q) ||
              t.address.toLowerCase().contains(q))
          .toList();
    }
    return result;
  });
});
