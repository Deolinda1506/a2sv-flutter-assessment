import 'package:equatable/equatable.dart';

/// Data model for detailed country information used in detail screen
class CountryDetails extends Equatable {
  final String cca2;
  final String name;
  final String flagPng;
  final String flagSvg;
  final int population;
  final String? capital;
  final String region;
  final String subregion;
  final double area;
  final List<String> timezones;

  const CountryDetails({
    required this.cca2,
    required this.name,
    required this.flagPng,
    required this.flagSvg,
    required this.population,
    this.capital,
    required this.region,
    required this.subregion,
    required this.area,
    required this.timezones,
  });

  factory CountryDetails.fromJson(Map<String, dynamic> json) {
    final capitals = json['capital'] as List<dynamic>?;
    final timezones = json['timezones'] as List<dynamic>?;

    return CountryDetails(
      cca2: json['cca2'] ?? '',
      name: json['name']?['common'] ?? '',
      flagPng: json['flags']?['png'] ?? '',
      flagSvg: json['flags']?['svg'] ?? '',
      population: json['population'] ?? 0,
      capital: capitals != null && capitals.isNotEmpty ? capitals[0] : null,
      region: json['region'] ?? '',
      subregion: json['subregion'] ?? '',
      area: (json['area'] ?? 0).toDouble(),
      timezones: timezones?.map((e) => e.toString()).toList() ?? [],
    );
  }

  /// Formats population as a readable string (e.g., "47.1M", "1.38B")
  String get formattedPopulation {
    if (population >= 1000000000) {
      return '${(population / 1000000000).toStringAsFixed(2)} billion';
    } else if (population >= 1000000) {
      return '${(population / 1000000).toStringAsFixed(2)} million';
    } else if (population >= 1000) {
      return '${(population / 1000).toStringAsFixed(1)} thousand';
    }
    return population.toString();
  }

  /// Formats area as a readable string with commas
  String get formattedArea {
    return '${area.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )} sq km';
  }

  @override
  List<Object?> get props => [
        cca2,
        name,
        flagPng,
        flagSvg,
        population,
        capital,
        region,
        subregion,
        area,
        timezones,
      ];
}
