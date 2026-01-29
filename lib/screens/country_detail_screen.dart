import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/country_detail/country_detail_bloc.dart';
import '../bloc/country_detail/country_detail_event.dart';
import '../bloc/country_detail/country_detail_state.dart';
import '../di/service_locator.dart';

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
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            countryName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
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
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        state.message,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<CountryDetailBloc>().add(
                              RetryLoadCountryDetail(cca2),
                            );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
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
                    // Flag image
                    Hero(
                      tag: 'flag_${country.cca2}',
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.teal[100],
                        ),
                        child: Image.network(
                          country.flagPng,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.flag,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Key Statistics
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Key Statistics',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildStatRow('Area', country.formattedArea),
                          const SizedBox(height: 12),
                          _buildStatRow('Population', country.formattedPopulation),
                          const SizedBox(height: 12),
                          _buildStatRow('Region', country.region),
                          const SizedBox(height: 12),
                          _buildStatRow('Sub Region', country.subregion),
                          const SizedBox(height: 32),
                          // Timezone section
                          const Text(
                            'Timezone',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  timezone,
                                  style: const TextStyle(
                                    fontSize: 14,
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

  Widget _buildStatRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
