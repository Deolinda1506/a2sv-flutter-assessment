import 'package:freezed_annotation/freezed_annotation.dart';

import 'country_summary.dart';

part 'country_details.freezed.dart';
part 'country_details.g.dart';

/// First element of capital array, or null
String? _capitalFromJson(dynamic v) {
  if (v is List && v.isNotEmpty) return v[0] as String?;
  return null;
}

/// Data model for detailed country information used in detail screen
@Freezed(fromJson: true)
class CountryDetails with _$CountryDetails {
  const CountryDetails._();

  const factory CountryDetails({
    @Default('') String cca2,
    @JsonKey(name: 'name') required NameDto nameDto,
    @JsonKey(name: 'flags') required FlagsDto flagsDto,
    @Default(0) int population,
    @JsonKey(fromJson: _capitalFromJson) String? capital,
    @Default('') String region,
    @Default('') String subregion,
    @Default(0.0) double area,
    @Default([]) List<String> timezones,
  }) = _CountryDetails;

  factory CountryDetails.fromJson(Map<String, dynamic> json) =>
      _$CountryDetailsFromJson(json);

  String get name => nameDto.common;
  String get flagPng => flagsDto.png;
  String get flagSvg => flagsDto.svg;

  /// Formats population as a readable string
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
}
