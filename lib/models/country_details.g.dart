// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CountryDetailsImpl _$$CountryDetailsImplFromJson(Map<String, dynamic> json) =>
    _$CountryDetailsImpl(
      cca2: json['cca2'] as String? ?? '',
      nameDto: NameDto.fromJson(json['name'] as Map<String, dynamic>),
      flagsDto: FlagsDto.fromJson(json['flags'] as Map<String, dynamic>),
      population: (json['population'] as num?)?.toInt() ?? 0,
      capital: _capitalFromJson(json['capital']),
      region: json['region'] as String? ?? '',
      subregion: json['subregion'] as String? ?? '',
      area: (json['area'] as num?)?.toDouble() ?? 0.0,
      timezones:
          (json['timezones'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CountryDetailsImplToJson(
  _$CountryDetailsImpl instance,
) => <String, dynamic>{
  'cca2': instance.cca2,
  'name': instance.nameDto,
  'flags': instance.flagsDto,
  'population': instance.population,
  'capital': instance.capital,
  'region': instance.region,
  'subregion': instance.subregion,
  'area': instance.area,
  'timezones': instance.timezones,
};
