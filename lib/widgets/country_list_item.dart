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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: SizedBox(
            height: 56,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Column 1: flags (fixed size, rounded corners, no box/border)
                SizedBox(
                  width: 56,
                  height: 40,
                  child: Hero(
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
                ),
              const SizedBox(width: 16),
              // Column 2: name + population (takes remaining space so names align)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      country.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Population: ${country.formattedPopulation}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Column 3: hearts (fixed width so all hearts align on the right)
              Semantics(
                label: isFavorite
                    ? 'Remove ${country.name} from favorites'
                    : 'Add ${country.name} to favorites',
                button: true,
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: onFavoriteTap,
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
