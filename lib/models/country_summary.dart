import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_summary.freezed.dart';
part 'country_summary.g.dart';

/// Nested DTO for API name object
@Freezed(fromJson: true)
class NameDto with _$NameDto {
  const factory NameDto({
    @JsonKey(name: 'common') @Default('') String common,
  }) = _NameDto;

  factory NameDto.fromJson(Map<String, dynamic> json) =>
      _$NameDtoFromJson(json);
}

/// Nested DTO for API flags object
@Freezed(fromJson: true)
class FlagsDto with _$FlagsDto {
  const factory FlagsDto({
    @Default('') String png,
    @Default('') String svg,
  }) = _FlagsDto;

  factory FlagsDto.fromJson(Map<String, dynamic> json) =>
      _$FlagsDtoFromJson(json);
}

/// Data model for country summary information used in lists
@Freezed(fromJson: true)
class CountrySummary with _$CountrySummary {
  const CountrySummary._();

  const factory CountrySummary({
    @JsonKey(name: 'name') required NameDto nameDto,
    @JsonKey(name: 'flags') required FlagsDto flagsDto,
    @Default(0) int population,
    @Default('') String cca2,
  }) = _CountrySummary;

  factory CountrySummary.fromJson(Map<String, dynamic> json) =>
      _$CountrySummaryFromJson(json);

  String get name => nameDto.common;
  String get flagPng => flagsDto.png;
  String get flagSvg => flagsDto.svg;

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
}
