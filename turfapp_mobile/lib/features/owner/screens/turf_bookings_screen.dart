import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/models/turf_model.dart';
import '../../../shared/widgets/booking_tile.dart';
import '../../booking/providers/booking_provider.dart';

class TurfBookingsScreen extends ConsumerWidget {
  final TurfModel turf;

  const TurfBookingsScreen({super.key, required this.turf});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsAsync = ref.watch(ownerTurfBookingsProvider(turf.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(turf.name),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: AppColors.divider),
        ),
      ),
      body: bookingsAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.accent)),
        error: (e, _) =>
            const Center(child: Text('Error loading bookings.', style: TextStyle(color: AppColors.error))),
        data: (bookings) {
          if (bookings.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today_outlined,
                      size: 52, color: AppColors.textDisabled),
                  SizedBox(height: 16),
                  Text('No bookings yet for this turf.',
                      style: TextStyle(color: AppColors.textSecondary)),
                ],
              ),
            );
          }

          final upcoming = bookings
              .where((b) => DateTime.tryParse(b.date)?.isAfter(
                      DateTime.now().subtract(const Duration(days: 1))) ??
                  false)
              .toList();
          final past = bookings
              .where((b) =>
                  !(DateTime.tryParse(b.date)?.isAfter(
                          DateTime.now().subtract(const Duration(days: 1))) ??
                      false))
              .toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              if (upcoming.isNotEmpty) ...[
                _SectionHeader(
                    label: 'Upcoming (${upcoming.length})'),
                const SizedBox(height: 10),
                ...upcoming.map((b) => BookingTile(booking: b)),
              ],
              if (past.isNotEmpty) ...[
                const SizedBox(height: 16),
                _SectionHeader(label: 'Past (${past.length})'),
                const SizedBox(height: 10),
                ...past.map((b) => BookingTile(booking: b)),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: AppColors.textSecondary, fontSize: 13),
    );
  }
}
