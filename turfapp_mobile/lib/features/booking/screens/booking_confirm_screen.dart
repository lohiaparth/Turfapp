import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/models/booking_model.dart';
import '../../../shared/models/turf_model.dart';
import '../../../features/auth/providers/auth_provider.dart';
import '../providers/booking_provider.dart';

class BookingConfirmScreen extends ConsumerWidget {
  final TurfModel turf;
  final String date;
  final BookingSlot slot;

  const BookingConfirmScreen({
    super.key,
    required this.turf,
    required this.date,
    required this.slot,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final bookingState = ref.watch(bookingNotifierProvider);
    final dateObj = DateTime.tryParse(date);
    final dateLabel =
        dateObj != null ? DateFormat('EEEE, d MMMM yyyy').format(dateObj) : date;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Booking'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SummaryCard(
              turf: turf,
              dateLabel: dateLabel,
              slot: slot,
            ),
            const SizedBox(height: 24),
            const _PayAtVenueBadge(),
            const Spacer(),
            ElevatedButton(
              onPressed: bookingState.isLoading
                  ? null
                  : () async {
                      final user = userAsync.valueOrNull;
                      if (user == null) return;
                      final booking = BookingModel(
                        id: '',
                        turfId: turf.id,
                        turfName: turf.name,
                        playerUid: user.uid,
                        playerName: user.fullname,
                        date: date,
                        slot: slot,
                        status: BookingStatus.confirmed,
                        totalPrice: turf.pricePerSlot,
                        createdAt: DateTime.now(),
                      );
                      final success = await ref
                          .read(bookingNotifierProvider.notifier)
                          .createBooking(booking);
                      if (success && context.mounted) {
                        _showSuccess(context);
                      }
                    },
              child: bookingState.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: AppColors.onAccent),
                    )
                  : const Text('Confirm Booking'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.pop(),
              child: const Text('Go Back'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded,
                    color: AppColors.accent, size: 34),
              ),
              const SizedBox(height: 20),
              const Text(
                'Booking Confirmed!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your slot at ${turf.name} is reserved.\nPay at the venue.',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.go('/bookings');
                },
                child: const Text('View My Bookings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final TurfModel turf;
  final String dateLabel;
  final BookingSlot slot;

  const _SummaryCard(
      {required this.turf, required this.dateLabel, required this.slot});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Booking Summary',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 16),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 14),
          _row(context, 'Turf', turf.name),
          const SizedBox(height: 10),
          _row(context, 'Address', turf.address),
          const SizedBox(height: 10),
          _row(context, 'Date', dateLabel),
          const SizedBox(height: 10),
          _row(context, 'Slot', '${slot.label}  ·  ${slot.timeRange}'),
          const SizedBox(height: 14),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total',
                  style: Theme.of(context).textTheme.titleMedium),
              Text(
                '₹${turf.pricePerSlot.toStringAsFixed(0)}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.accent, fontSize: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(width: 24),
        Flexible(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class _PayAtVenueBadge extends StatelessWidget {
  const _PayAtVenueBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.payments_outlined,
              color: AppColors.accent, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Payment is collected at the venue. No upfront payment required.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.accent, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
