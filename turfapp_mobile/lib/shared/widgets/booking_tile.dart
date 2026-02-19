import 'package:flutter/material.dart';
import '../../shared/models/booking_model.dart';
import '../../core/theme/app_theme.dart';
import 'package:intl/intl.dart';

class BookingTile extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback? onCancel;

  const BookingTile({super.key, required this.booking, this.onCancel});

  @override
  Widget build(BuildContext context) {
    final dateObj = DateTime.tryParse(booking.date);
    final dateLabel = dateObj != null
        ? DateFormat('EEE, d MMM yyyy').format(dateObj)
        : booking.date;
    final isCancelled = booking.status == BookingStatus.cancelled;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCancelled ? AppColors.divider : AppColors.divider,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isCancelled
                  ? AppColors.surfaceVariant
                  : AppColors.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.sports_soccer,
              color: isCancelled ? AppColors.textDisabled : AppColors.accent,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.turfName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration:
                            isCancelled ? TextDecoration.lineThrough : null,
                        color:
                            isCancelled ? AppColors.textDisabled : null,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(dateLabel,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 3),
                Text(
                  '${booking.slot.label}  ·  ${booking.slot.timeRange}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${booking.totalPrice.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color:
                          isCancelled ? AppColors.textDisabled : AppColors.accent,
                    ),
              ),
              const SizedBox(height: 6),
              _StatusBadge(
                  cancelled: isCancelled),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool cancelled;
  const _StatusBadge({required this.cancelled});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: cancelled
            ? AppColors.divider
            : AppColors.accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        cancelled ? 'Cancelled' : 'Confirmed',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: cancelled ? AppColors.textDisabled : AppColors.accent,
        ),
      ),
    );
  }
}
