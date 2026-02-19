import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../shared/models/turf_model.dart';
import '../../core/theme/app_theme.dart';

class TurfCard extends StatelessWidget {
  final TurfModel turf;
  final VoidCallback onTap;

  const TurfCard({super.key, required this.turf, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    turf.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 13, color: AppColors.textDisabled),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          turf.address,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 12,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: _buildSportChips(context)),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹${turf.pricePerSlot.toStringAsFixed(0)}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppColors.accent),
                          ),
                          Text(
                            'per slot',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (turf.imageUrls.isEmpty) {
      return Container(
        height: 160,
        color: AppColors.surfaceVariant,
        child: const Center(
          child: Icon(Icons.sports_soccer,
              size: 48, color: AppColors.textDisabled),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: turf.imageUrls.first,
      height: 160,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: (_, __) => Shimmer.fromColors(
        baseColor: AppColors.surface,
        highlightColor: AppColors.surfaceVariant,
        child: Container(height: 160, color: AppColors.surface),
      ),
      errorWidget: (_, __, ___) => Container(
        height: 160,
        color: AppColors.surfaceVariant,
        child: const Center(
          child: Icon(Icons.broken_image_outlined,
              size: 40, color: AppColors.textDisabled),
        ),
      ),
    );
  }

  Widget _buildSportChips(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: turf.sports.take(3).map((sport) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            sport,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        );
      }).toList(),
    );
  }
}
