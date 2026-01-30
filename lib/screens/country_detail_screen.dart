import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bloc/country_detail/country_detail_bloc.dart';
import '../bloc/country_detail/country_detail_event.dart';
import '../bloc/country_detail/country_detail_state.dart';
import '../di/service_locator.dart';
import '../models/country_details.dart';

/// Screen displaying detailed information about a country
class CountryDetailScreen extends StatelessWidget {
  final String cca2;
  final String countryName;

  const CountryDetailScreen({
    super.key,
    required this.cca2,
    required this.countryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountryDetailBloc(
        apiService: getIt(),
      )..add(LoadCountryDetail(cca2)),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            countryName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        body: BlocBuilder<CountryDetailBloc, CountryDetailState>(
          builder: (context, state) {
            if (state is CountryDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CountryDetailError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        state.message,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Semantics(
                      label: 'Retry loading country details',
                      button: true,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.read<CountryDetailBloc>().add(
                                RetryLoadCountryDetail(cca2),
                              );
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is CountryDetailLoaded) {
              final country = state.country;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Flag image (large, rounded corners, teal background per Figma)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Hero(
                        tag: 'flag_${country.cca2}',
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(11),
                            child: Container(
                              width: double.infinity,
                              height: 250,
                              color: Theme.of(context).colorScheme.surfaceContainerHighest,
                              child: _buildDetailFlag(context, country),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Key Statistics
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Key Statistics',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildStatRow(context, 'Area', country.formattedArea),
                          const SizedBox(height: 12),
                          _buildStatRow(context, 'Population', country.formattedPopulation),
                          const SizedBox(height: 12),
                          _buildStatRow(context, 'Region', country.region),
                          const SizedBox(height: 12),
                          _buildStatRow(context, 'Sub Region', country.subregion),
                          const SizedBox(height: 32),
                          // Timezone section
                          Text(
                            'Timezone',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: country.timezones.map((timezone) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).colorScheme.outline),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  timezone,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  /// Use SVG when available for sharp scaling at large size; fallback to PNG with high filter quality.
  Widget _buildDetailFlag(BuildContext context, CountryDetails country) {
    final noFlag = country.flagPng.isEmpty && country.flagSvg.isEmpty;
    if (noFlag) {
      return Center(
        child: Icon(
          Icons.flag,
          size: 64,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      );
    }
    // Prefer SVG: scales to any size without quality loss (high-quality at 250px height)
    if (country.flagSvg.isNotEmpty) {
      return SvgPicture.network(
        country.flagSvg,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 250,
        placeholderBuilder: (context) => Center(
          child: SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(strokeWidth: 2, color: Theme.of(context).colorScheme.primary),
          ),
        ),
      );
    }
    return Image.network(
      country.flagPng,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 250,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(
            Icons.flag,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        );
      },
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
