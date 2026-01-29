// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NameDtoImpl _$$NameDtoImplFromJson(Map<String, dynamic> json) =>
    _$NameDtoImpl(common: json['common'] as String? ?? '');

Map<String, dynamic> _$$NameDtoImplToJson(_$NameDtoImpl instance) =>
    <String, dynamic>{'common': instance.common};

_$FlagsDtoImpl _$$FlagsDtoImplFromJson(Map<String, dynamic> json) =>
    _$FlagsDtoImpl(
      png: json['png'] as String? ?? '',
      svg: json['svg'] as String? ?? '',
    );

Map<String, dynamic> _$$FlagsDtoImplToJson(_$FlagsDtoImpl instance) =>
    <String, dynamic>{'png': instance.png, 'svg': instance.svg};

_$CountrySummaryImpl _$$CountrySummaryImplFromJson(Map<String, dynamic> json) =>
    _$CountrySummaryImpl(
      nameDto: NameDto.fromJson(json['name'] as Map<String, dynamic>),
      flagsDto: FlagsDto.fromJson(json['flags'] as Map<String, dynamic>),
      population: (json['population'] as num?)?.toInt() ?? 0,
      cca2: json['cca2'] as String? ?? '',
    );

Map<String, dynamic> _$$CountrySummaryImplToJson(
  _$CountrySummaryImpl instance,
) => <String, dynamic>{
  'name': instance.nameDto,
  'flags': instance.flagsDto,
  'population': instance.population,
  'cca2': instance.cca2,
};
