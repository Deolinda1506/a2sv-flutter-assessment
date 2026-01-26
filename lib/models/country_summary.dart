import 'package:equatable/equatable.dart';

/// Data model for country summary information used in lists
class CountrySummary extends Equatable {
  final String name;
  final String flagPng;
  final String flagSvg;
  final int population;
  final String cca2;

  const CountrySummary({
    required this.name,
    required this.flagPng,
    required this.flagSvg,
    required this.population,
    required this.cca2,
  });

  factory CountrySummary.fromJson(Map<String, dynamic> json) {
    return CountrySummary(
      name: json['name']?['common'] ?? '',
      flagPng: json['flags']?['png'] ?? '',
      flagSvg: json['flags']?['svg'] ?? '',
      population: json['population'] ?? 0,
      cca2: json['cca2'] ?? '',
    );
  }

  /// Formats population as a readable string (e.g., "47.1M", "1.38B")
  String get formattedPopulation {
    if (population >= 1000000000) {
      return '${(population / 1000000000).toStringAsFixed(2)}B';
    } else if (population >= 1000000) {
      return '${(population / 1000000).toStringAsFixed(1)}M';
    } else if (population >= 1000) {
      return '${(population / 1000).toStringAsFixed(1)}K';
    }
    return population.toString();
  }

  @override
  List<Object?> get props => [name, flagPng, flagSvg, population, cca2];
}
