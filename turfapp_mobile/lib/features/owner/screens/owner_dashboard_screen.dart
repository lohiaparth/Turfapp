import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/models/turf_model.dart';
import '../../../shared/widgets/turf_card.dart';
import '../providers/owner_provider.dart';

class OwnerDashboardScreen extends ConsumerWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final turfsAsync = ref.watch(ownerTurfsProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: const Icon(Icons.sports_soccer,
                                  color: AppColors.onAccent, size: 16),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'TurfApp',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('My Turfs',
                        style: Theme.of(context).textTheme.displayMedium),
                    const SizedBox(height: 4),
                    Text(
                      'Manage your listings and view bookings.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            turfsAsync.when(
              loading: () => const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 60),
                    child:
                        CircularProgressIndicator(color: AppColors.accent),
                  ),
                ),
              ),
              error: (e, _) => SliverToBoxAdapter(
                child: Center(
                  child: Text('Error loading turfs.',
                      style: TextStyle(color: AppColors.error)),
                ),
              ),
              data: (turfs) {
                if (turfs.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(
                        children: [
                          const Icon(Icons.add_location_alt_outlined,
                              size: 52, color: AppColors.textDisabled),
                          const SizedBox(height: 16),
                          const Text('No turfs listed yet.',
                              style:
                                  TextStyle(color: AppColors.textSecondary)),
                          const SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40),
                            child: ElevatedButton(
                              onPressed: () => context.push('/owner/add-turf'),
                              child: const Text('List Your First Turf'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _OwnerTurfCard(turf: turfs[i]),
                      ),
                      childCount: turfs.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/owner/add-turf'),
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.onAccent,
        icon: const Icon(Icons.add),
        label: const Text(
          'Add Turf',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _OwnerTurfCard extends ConsumerWidget {
  final TurfModel turf;

  const _OwnerTurfCard({required this.turf});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        TurfCard(
          turf: turf,
          onTap: () => context.push('/owner/turf/${turf.id}/bookings', extra: turf),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () =>
                    context.push('/owner/edit-turf', extra: turf),
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: const Text('Edit'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () =>
                    context.push('/owner/turf/${turf.id}/bookings', extra: turf),
                icon: const Icon(Icons.calendar_month_outlined, size: 16),
                label: const Text('Bookings'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
