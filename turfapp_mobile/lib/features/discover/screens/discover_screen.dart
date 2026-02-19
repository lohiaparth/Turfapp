import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/models/models.dart';
import '../../../shared/widgets/turf_card.dart';
import '../providers/turf_provider.dart';

const _sports = ['Football', 'Cricket', 'Basketball'];

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredTurfs = ref.watch(filteredTurfsProvider);
    final filter = ref.watch(turfFilterProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context),
            _buildSearchBar(filter),
            _buildSportFilter(filter),
            _buildTurfList(filteredTurfs),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAppBar(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Find a Turf', style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 4),
            Text(
              'Browse, pick a slot, and play.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSearchBar(TurfFilter filter) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: _searchCtrl,
          onChanged: (v) {
            ref.read(turfFilterProvider.notifier).state =
                filter.copyWith(query: v);
          },
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: 'Search by name or area…',
            prefixIcon: const Icon(Icons.search, color: AppColors.textDisabled),
            suffixIcon: _searchCtrl.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close,
                        color: AppColors.textDisabled, size: 18),
                    onPressed: () {
                      _searchCtrl.clear();
                      ref.read(turfFilterProvider.notifier).state =
                          filter.copyWith(query: '');
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSportFilter(TurfFilter filter) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          children: [
            _SportChip(
              label: 'All',
              selected: filter.sport == null,
              onTap: () {
                ref.read(turfFilterProvider.notifier).state =
                    filter.copyWith(clearSport: true);
              },
            ),
            const SizedBox(width: 8),
            ..._sports.map((s) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _SportChip(
                    label: s,
                    selected: filter.sport == s,
                    onTap: () {
                      ref.read(turfFilterProvider.notifier).state =
                          filter.copyWith(sport: s);
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildTurfList(AsyncValue<List<TurfModel>> turfsAsync) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      sliver: turfsAsync.when(
        loading: () => const SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 60),
              child: CircularProgressIndicator(color: AppColors.accent),
            ),
          ),
        ),
        error: (e, _) => SliverToBoxAdapter(
          child: Center(
            child: Text('Error loading turfs',
                style: TextStyle(color: AppColors.error)),
          ),
        ),
        data: (turfs) {
          if (turfs.isEmpty) {
            return const SliverToBoxAdapter(
              child: _EmptyState(),
            );
          }
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TurfCard(
                  turf: turfs[i],
                  onTap: () => context.push('/discover/${turfs[i].id}',
                      extra: turfs[i]),
                ),
              ),
              childCount: turfs.length,
            ),
          );
        },
      ),
    );
  }
}

class _SportChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SportChip(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.divider,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.onAccent : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 60),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 52, color: AppColors.textDisabled),
          SizedBox(height: 16),
          Text('No turfs found', style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
