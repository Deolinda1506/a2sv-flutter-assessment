import 'package:flutter/material.dart';
import '../models/country_summary.dart';

/// Widget for displaying a country item in the list
class CountryListItem extends StatelessWidget {
  final CountrySummary country;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const CountryListItem({
    super.key,
    required this.country,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${country.name}, Population: ${country.formattedPopulation}. Double tap to view details.',
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Flag (placeholder when no URL or load fails)
              Hero(
                tag: 'flag_${country.cca2}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: country.flagPng.isEmpty
                      ? _buildNoFlagPlaceholder(context, 56, 40)
                      : Image.network(
                          country.flagPng,
                          width: 56,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildNoFlagPlaceholder(context, 56, 40);
                          },
                        ),
                ),
              ),
            const SizedBox(width: 16),
            // Country name and population
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Population: ${country.formattedPopulation}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            // Favorite icon
            Semantics(
              label: isFavorite
                  ? 'Remove ${country.name} from favorites'
                  : 'Add ${country.name} to favorites',
              button: true,
              child: IconButton(
                onPressed: onFavoriteTap,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildNoFlagPlaceholder(BuildContext context, double width, double height) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      color: colorScheme.surfaceContainerHighest,
      child: Icon(Icons.flag, size: 24, color: colorScheme.onSurfaceVariant),
    );
  }
}
