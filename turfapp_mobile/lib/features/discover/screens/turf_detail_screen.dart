import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/models/turf_model.dart';

class TurfDetailScreen extends StatelessWidget {
  final TurfModel turf;

  const TurfDetailScreen({super.key, required this.turf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildHeroAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 20),
                  _buildInfoRow(context),
                  const SizedBox(height: 24),
                  _buildSectionTitle(context, 'Sports Available'),
                  const SizedBox(height: 10),
                  _buildSportChips(),
                  const SizedBox(height: 24),
                  _buildSectionTitle(context, 'Contact'),
                  const SizedBox(height: 10),
                  _buildContact(context),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () =>
                        context.push('/discover/${turf.id}/slots', extra: turf),
                    child: const Text('Book a Slot'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildHeroAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      backgroundColor: AppColors.background,
      leading: GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.arrow_back_ios_new,
              size: 18, color: AppColors.textPrimary),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: turf.imageUrls.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: turf.imageUrls.first,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.surfaceVariant,
                  child: const Icon(Icons.sports_soccer,
                      size: 64, color: AppColors.textDisabled),
                ),
              )
            : Container(
                color: AppColors.surfaceVariant,
                child: const Center(
                  child: Icon(Icons.sports_soccer,
                      size: 64, color: AppColors.textDisabled),
                ),
              ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(turf.name,
              style: Theme.of(context).textTheme.displayMedium),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹${turf.pricePerSlot.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppColors.accent,
                    fontSize: 28,
                  ),
            ),
            Text(
              'per slot',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined,
            size: 16, color: AppColors.textDisabled),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            turf.address,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: AppColors.textSecondary, fontSize: 13));
  }

  Widget _buildSportChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: turf.sports.map((sport) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.divider),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            sport,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContact(BuildContext context) {
    return Column(
      children: [
        _contactRow(context, Icons.phone_outlined, turf.contact1),
        if (turf.contact2 != null && turf.contact2!.isNotEmpty) ...[
          const SizedBox(height: 6),
          _contactRow(context, Icons.phone_outlined, turf.contact2!),
        ],
      ],
    );
  }

  Widget _contactRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.accent),
        const SizedBox(width: 8),
        Text(text, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
