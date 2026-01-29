// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NameDto _$NameDtoFromJson(Map<String, dynamic> json) {
  return _NameDto.fromJson(json);
}

/// @nodoc
mixin _$NameDto {
  @JsonKey(name: 'common')
  String get common => throw _privateConstructorUsedError;

  /// Serializes this NameDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NameDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NameDtoCopyWith<NameDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NameDtoCopyWith<$Res> {
  factory $NameDtoCopyWith(NameDto value, $Res Function(NameDto) then) =
      _$NameDtoCopyWithImpl<$Res, NameDto>;
  @useResult
  $Res call({@JsonKey(name: 'common') String common});
}

/// @nodoc
class _$NameDtoCopyWithImpl<$Res, $Val extends NameDto>
    implements $NameDtoCopyWith<$Res> {
  _$NameDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NameDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? common = null}) {
    return _then(
      _value.copyWith(
            common: null == common
                ? _value.common
                : common // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NameDtoImplCopyWith<$Res> implements $NameDtoCopyWith<$Res> {
  factory _$$NameDtoImplCopyWith(
    _$NameDtoImpl value,
    $Res Function(_$NameDtoImpl) then,
  ) = __$$NameDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'common') String common});
}

/// @nodoc
class __$$NameDtoImplCopyWithImpl<$Res>
    extends _$NameDtoCopyWithImpl<$Res, _$NameDtoImpl>
    implements _$$NameDtoImplCopyWith<$Res> {
  __$$NameDtoImplCopyWithImpl(
    _$NameDtoImpl _value,
    $Res Function(_$NameDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NameDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? common = null}) {
    return _then(
      _$NameDtoImpl(
        common: null == common
            ? _value.common
            : common // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NameDtoImpl implements _NameDto {
  const _$NameDtoImpl({@JsonKey(name: 'common') this.common = ''});

  factory _$NameDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NameDtoImplFromJson(json);

  @override
  @JsonKey(name: 'common')
  final String common;

  @override
  String toString() {
    return 'NameDto(common: $common)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NameDtoImpl &&
            (identical(other.common, common) || other.common == common));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, common);

  /// Create a copy of NameDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NameDtoImplCopyWith<_$NameDtoImpl> get copyWith =>
      __$$NameDtoImplCopyWithImpl<_$NameDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NameDtoImplToJson(this);
  }
}

abstract class _NameDto implements NameDto {
  const factory _NameDto({@JsonKey(name: 'common') final String common}) =
      _$NameDtoImpl;

  factory _NameDto.fromJson(Map<String, dynamic> json) = _$NameDtoImpl.fromJson;

  @override
  @JsonKey(name: 'common')
  String get common;

  /// Create a copy of NameDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NameDtoImplCopyWith<_$NameDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FlagsDto _$FlagsDtoFromJson(Map<String, dynamic> json) {
  return _FlagsDto.fromJson(json);
}

/// @nodoc
mixin _$FlagsDto {
  String get png => throw _privateConstructorUsedError;
  String get svg => throw _privateConstructorUsedError;

  /// Serializes this FlagsDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FlagsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlagsDtoCopyWith<FlagsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlagsDtoCopyWith<$Res> {
  factory $FlagsDtoCopyWith(FlagsDto value, $Res Function(FlagsDto) then) =
      _$FlagsDtoCopyWithImpl<$Res, FlagsDto>;
  @useResult
  $Res call({String png, String svg});
}

/// @nodoc
class _$FlagsDtoCopyWithImpl<$Res, $Val extends FlagsDto>
    implements $FlagsDtoCopyWith<$Res> {
  _$FlagsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlagsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? png = null, Object? svg = null}) {
    return _then(
      _value.copyWith(
            png: null == png
                ? _value.png
                : png // ignore: cast_nullable_to_non_nullable
                      as String,
            svg: null == svg
                ? _value.svg
                : svg // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FlagsDtoImplCopyWith<$Res>
    implements $FlagsDtoCopyWith<$Res> {
  factory _$$FlagsDtoImplCopyWith(
    _$FlagsDtoImpl value,
    $Res Function(_$FlagsDtoImpl) then,
  ) = __$$FlagsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String png, String svg});
}

/// @nodoc
class __$$FlagsDtoImplCopyWithImpl<$Res>
    extends _$FlagsDtoCopyWithImpl<$Res, _$FlagsDtoImpl>
    implements _$$FlagsDtoImplCopyWith<$Res> {
  __$$FlagsDtoImplCopyWithImpl(
    _$FlagsDtoImpl _value,
    $Res Function(_$FlagsDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FlagsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? png = null, Object? svg = null}) {
    return _then(
      _$FlagsDtoImpl(
        png: null == png
            ? _value.png
            : png // ignore: cast_nullable_to_non_nullable
                  as String,
        svg: null == svg
            ? _value.svg
            : svg // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FlagsDtoImpl implements _FlagsDto {
  const _$FlagsDtoImpl({this.png = '', this.svg = ''});

  factory _$FlagsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlagsDtoImplFromJson(json);

  @override
  @JsonKey()
  final String png;
  @override
  @JsonKey()
  final String svg;

  @override
  String toString() {
    return 'FlagsDto(png: $png, svg: $svg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlagsDtoImpl &&
            (identical(other.png, png) || other.png == png) &&
            (identical(other.svg, svg) || other.svg == svg));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, png, svg);

  /// Create a copy of FlagsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlagsDtoImplCopyWith<_$FlagsDtoImpl> get copyWith =>
      __$$FlagsDtoImplCopyWithImpl<_$FlagsDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlagsDtoImplToJson(this);
  }
}

abstract class _FlagsDto implements FlagsDto {
  const factory _FlagsDto({final String png, final String svg}) =
      _$FlagsDtoImpl;

  factory _FlagsDto.fromJson(Map<String, dynamic> json) =
      _$FlagsDtoImpl.fromJson;

  @override
  String get png;
  @override
  String get svg;

  /// Create a copy of FlagsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlagsDtoImplCopyWith<_$FlagsDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CountrySummary _$CountrySummaryFromJson(Map<String, dynamic> json) {
  return _CountrySummary.fromJson(json);
}

/// @nodoc
mixin _$CountrySummary {
  @JsonKey(name: 'name')
  NameDto get nameDto => throw _privateConstructorUsedError;
  @JsonKey(name: 'flags')
  FlagsDto get flagsDto => throw _privateConstructorUsedError;
  int get population => throw _privateConstructorUsedError;
  String get cca2 => throw _privateConstructorUsedError;

  /// Serializes this CountrySummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CountrySummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CountrySummaryCopyWith<CountrySummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountrySummaryCopyWith<$Res> {
  factory $CountrySummaryCopyWith(
    CountrySummary value,
    $Res Function(CountrySummary) then,
  ) = _$CountrySummaryCopyWithImpl<$Res, CountrySummary>;
  @useResult
  $Res call({
    @JsonKey(name: 'name') NameDto nameDto,
    @JsonKey(name: 'flags') FlagsDto flagsDto,
    int population,
    String cca2,
  });

  $NameDtoCopyWith<$Res> get nameDto;
  $FlagsDtoCopyWith<$Res> get flagsDto;
}

/// @nodoc
class _$CountrySummaryCopyWithImpl<$Res, $Val extends CountrySummary>
    implements $CountrySummaryCopyWith<$Res> {
  _$CountrySummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CountrySummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameDto = null,
    Object? flagsDto = null,
    Object? population = null,
    Object? cca2 = null,
  }) {
    return _then(
      _value.copyWith(
            nameDto: null == nameDto
                ? _value.nameDto
                : nameDto // ignore: cast_nullable_to_non_nullable
                      as NameDto,
            flagsDto: null == flagsDto
                ? _value.flagsDto
                : flagsDto // ignore: cast_nullable_to_non_nullable
                      as FlagsDto,
            population: null == population
                ? _value.population
                : population // ignore: cast_nullable_to_non_nullable
                      as int,
            cca2: null == cca2
                ? _value.cca2
                : cca2 // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of CountrySummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NameDtoCopyWith<$Res> get nameDto {
    return $NameDtoCopyWith<$Res>(_value.nameDto, (value) {
      return _then(_value.copyWith(nameDto: value) as $Val);
    });
  }

  /// Create a copy of CountrySummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FlagsDtoCopyWith<$Res> get flagsDto {
    return $FlagsDtoCopyWith<$Res>(_value.flagsDto, (value) {
      return _then(_value.copyWith(flagsDto: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CountrySummaryImplCopyWith<$Res>
    implements $CountrySummaryCopyWith<$Res> {
  factory _$$CountrySummaryImplCopyWith(
    _$CountrySummaryImpl value,
    $Res Function(_$CountrySummaryImpl) then,
  ) = __$$CountrySummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'name') NameDto nameDto,
    @JsonKey(name: 'flags') FlagsDto flagsDto,
    int population,
    String cca2,
  });

  @override
  $NameDtoCopyWith<$Res> get nameDto;
  @override
  $FlagsDtoCopyWith<$Res> get flagsDto;
}

/// @nodoc
class __$$CountrySummaryImplCopyWithImpl<$Res>
    extends _$CountrySummaryCopyWithImpl<$Res, _$CountrySummaryImpl>
    implements _$$CountrySummaryImplCopyWith<$Res> {
  __$$CountrySummaryImplCopyWithImpl(
    _$CountrySummaryImpl _value,
    $Res Function(_$CountrySummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CountrySummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameDto = null,
    Object? flagsDto = null,
    Object? population = null,
    Object? cca2 = null,
  }) {
    return _then(
      _$CountrySummaryImpl(
        nameDto: null == nameDto
            ? _value.nameDto
            : nameDto // ignore: cast_nullable_to_non_nullable
                  as NameDto,
        flagsDto: null == flagsDto
            ? _value.flagsDto
            : flagsDto // ignore: cast_nullable_to_non_nullable
                  as FlagsDto,
        population: null == population
            ? _value.population
            : population // ignore: cast_nullable_to_non_nullable
                  as int,
        cca2: null == cca2
            ? _value.cca2
            : cca2 // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CountrySummaryImpl extends _CountrySummary {
  const _$CountrySummaryImpl({
    @JsonKey(name: 'name') required this.nameDto,
    @JsonKey(name: 'flags') required this.flagsDto,
    this.population = 0,
    this.cca2 = '',
  }) : super._();

  factory _$CountrySummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountrySummaryImplFromJson(json);

  @override
  @JsonKey(name: 'name')
  final NameDto nameDto;
  @override
  @JsonKey(name: 'flags')
  final FlagsDto flagsDto;
  @override
  @JsonKey()
  final int population;
  @override
  @JsonKey()
  final String cca2;

  @override
  String toString() {
    return 'CountrySummary(nameDto: $nameDto, flagsDto: $flagsDto, population: $population, cca2: $cca2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountrySummaryImpl &&
            (identical(other.nameDto, nameDto) || other.nameDto == nameDto) &&
            (identical(other.flagsDto, flagsDto) ||
                other.flagsDto == flagsDto) &&
            (identical(other.population, population) ||
                other.population == population) &&
            (identical(other.cca2, cca2) || other.cca2 == cca2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nameDto, flagsDto, population, cca2);

  /// Create a copy of CountrySummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountrySummaryImplCopyWith<_$CountrySummaryImpl> get copyWith =>
      __$$CountrySummaryImplCopyWithImpl<_$CountrySummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CountrySummaryImplToJson(this);
  }
}

abstract class _CountrySummary extends CountrySummary {
  const factory _CountrySummary({
    @JsonKey(name: 'name') required final NameDto nameDto,
    @JsonKey(name: 'flags') required final FlagsDto flagsDto,
    final int population,
    final String cca2,
  }) = _$CountrySummaryImpl;
  const _CountrySummary._() : super._();

  factory _CountrySummary.fromJson(Map<String, dynamic> json) =
      _$CountrySummaryImpl.fromJson;

  @override
  @JsonKey(name: 'name')
  NameDto get nameDto;
  @override
  @JsonKey(name: 'flags')
  FlagsDto get flagsDto;
  @override
  int get population;
  @override
  String get cca2;

  /// Create a copy of CountrySummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountrySummaryImplCopyWith<_$CountrySummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
