import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/models/booking_model.dart';
import '../../../shared/models/turf_model.dart';
import '../providers/booking_provider.dart';

class SlotPickerScreen extends ConsumerStatefulWidget {
  final TurfModel turf;

  const SlotPickerScreen({super.key, required this.turf});

  @override
  ConsumerState<SlotPickerScreen> createState() => _SlotPickerScreenState();
}

class _SlotPickerScreenState extends ConsumerState<SlotPickerScreen> {
  DateTime _selectedDate = DateTime.now();
  BookingSlot? _selectedSlot;

  String get _dateKey => DateFormat('yyyy-MM-dd').format(_selectedDate);

  @override
  Widget build(BuildContext context) {
    final bookedAsync = ref.watch(
      bookedSlotsProvider((turfId: widget.turf.id, date: _dateKey)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a Slot'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _turfSummary(context),
            const SizedBox(height: 28),
            _sectionLabel(context, 'Select Date'),
            const SizedBox(height: 12),
            _buildDatePicker(),
            const SizedBox(height: 28),
            _sectionLabel(context, 'Select Slot'),
            const SizedBox(height: 12),
            bookedAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppColors.accent),
              ),
              error: (e, _) =>
                  const Text('Could not load availability.',
                      style: TextStyle(color: AppColors.error)),
              data: (booked) => _buildSlotGrid(booked),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _selectedSlot == null ? null : _proceed,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _turfSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.sports_soccer, color: AppColors.accent, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.turf.name,
                    style: Theme.of(context).textTheme.titleMedium),
                Text(widget.turf.address,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Text(
            '₹${widget.turf.pricePerSlot.toStringAsFixed(0)}',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.accent),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    final today = DateTime.now();
    return SizedBox(
      height: 82,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 14,
        itemBuilder: (_, i) {
          final date = today.add(Duration(days: i));
          final isSelected = _dateKey == DateFormat('yyyy-MM-dd').format(date);
          return GestureDetector(
            onTap: () => setState(() {
              _selectedDate = date;
              _selectedSlot = null;
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 56,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accent : AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColors.accent : AppColors.divider,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(date),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? AppColors.onAccent
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? AppColors.onAccent
                          : AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    DateFormat('MMM').format(date),
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected
                          ? AppColors.onAccent
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSlotGrid(List<BookingSlot> booked) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.2,
      children: BookingSlot.values.map((slot) {
        final isBooked = booked.contains(slot);
        final isSelected = _selectedSlot == slot;
        return GestureDetector(
          onTap: isBooked ? null : () => setState(() => _selectedSlot = slot),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isBooked
                  ? AppColors.booked
                  : isSelected
                      ? AppColors.accent
                      : AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppColors.accent
                    : isBooked
                        ? AppColors.divider
                        : AppColors.divider,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  slot.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isBooked
                        ? AppColors.textDisabled
                        : isSelected
                            ? AppColors.onAccent
                            : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isBooked ? 'Unavailable' : slot.timeRange,
                  style: TextStyle(
                    fontSize: 11,
                    color: isBooked
                        ? AppColors.textDisabled
                        : isSelected
                            ? AppColors.onAccent.withValues(alpha: 0.7)
                            : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _sectionLabel(BuildContext context, String label) {
    return Text(label,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: AppColors.textSecondary, fontSize: 13));
  }

  void _proceed() {
    if (_selectedSlot == null) return;
    context.push(
      '/discover/${widget.turf.id}/confirm',
      extra: {
        'turf': widget.turf,
        'date': _dateKey,
        'slot': _selectedSlot!,
      },
    );
  }
}
