import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/turf_model.dart';
import '../../../features/auth/providers/auth_provider.dart';
import 'dart:io';

// ── Owner's turfs ─────────────────────────────────────────────────────────────
final ownerTurfsProvider = StreamProvider<List<TurfModel>>((ref) {
  final authState = ref.watch(authStateProvider);
  final uid = authState.valueOrNull?.uid;
  if (uid == null) return Stream.value([]);

  return FirebaseFirestore.instance
      .collection('turfs')
      .where('ownerUid', isEqualTo: uid)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map((d) => TurfModel.fromFirestore(d)).toList());
});

// ── Turf CRUD notifier ───────────────────────────────────────────────────────
class TurfNotifier extends StateNotifier<AsyncValue<void>> {
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  TurfNotifier(this._db, this._storage) : super(const AsyncValue.data(null));

  Future<bool> addTurf({
    required TurfModel turf,
    required List<File> imageFiles,
  }) async {
    state = const AsyncValue.loading();
    try {
      final urls = await _uploadImages(turf.ownerUid, imageFiles);
      final updated = turf.copyWith(imageUrls: urls);
      await _db.collection('turfs').add(updated.toMap());
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> updateTurf({
    required TurfModel turf,
    List<File>? newImageFiles,
  }) async {
    state = const AsyncValue.loading();
    try {
      List<String> imageUrls = turf.imageUrls;
      if (newImageFiles != null && newImageFiles.isNotEmpty) {
        imageUrls = await _uploadImages(turf.ownerUid, newImageFiles);
      }
      final updated = turf.copyWith(imageUrls: imageUrls);
      await _db.collection('turfs').doc(turf.id).update(updated.toMap());
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> deleteTurf(String turfId) async {
    state = const AsyncValue.loading();
    try {
      await _db.collection('turfs').doc(turfId).delete();
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<List<String>> _uploadImages(
      String ownerUid, List<File> files) async {
    final urls = <String>[];
    for (final file in files) {
      final ref = _storage.ref(
          'turfs/$ownerUid/${DateTime.now().millisecondsSinceEpoch}_${urls.length}.jpg');
      await ref.putFile(file);
      urls.add(await ref.getDownloadURL());
    }
    return urls;
  }
}

final turfNotifierProvider =
    StateNotifierProvider<TurfNotifier, AsyncValue<void>>(
  (ref) => TurfNotifier(
    FirebaseFirestore.instance,
    FirebaseStorage.instance,
  ),
);
