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
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Flag
            Hero(
              tag: 'flag_${country.cca2}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  country.flagPng,
                  width: 56,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 56,
                      height: 40,
                      color: Colors.grey[300],
                      child: const Icon(Icons.flag, size: 24),
                    );
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
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Population: ${country.formattedPopulation}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Favorite icon
            IconButton(
              onPressed: onFavoriteTap,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
