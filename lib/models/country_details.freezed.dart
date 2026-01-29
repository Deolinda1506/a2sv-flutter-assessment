// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CountryDetails _$CountryDetailsFromJson(Map<String, dynamic> json) {
  return _CountryDetails.fromJson(json);
}

/// @nodoc
mixin _$CountryDetails {
  String get cca2 => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  NameDto get nameDto => throw _privateConstructorUsedError;
  @JsonKey(name: 'flags')
  FlagsDto get flagsDto => throw _privateConstructorUsedError;
  int get population => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _capitalFromJson)
  String? get capital => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;
  String get subregion => throw _privateConstructorUsedError;
  double get area => throw _privateConstructorUsedError;
  List<String> get timezones => throw _privateConstructorUsedError;

  /// Serializes this CountryDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CountryDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CountryDetailsCopyWith<CountryDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountryDetailsCopyWith<$Res> {
  factory $CountryDetailsCopyWith(
    CountryDetails value,
    $Res Function(CountryDetails) then,
  ) = _$CountryDetailsCopyWithImpl<$Res, CountryDetails>;
  @useResult
  $Res call({
    String cca2,
    @JsonKey(name: 'name') NameDto nameDto,
    @JsonKey(name: 'flags') FlagsDto flagsDto,
    int population,
    @JsonKey(fromJson: _capitalFromJson) String? capital,
    String region,
    String subregion,
    double area,
    List<String> timezones,
  });

  $NameDtoCopyWith<$Res> get nameDto;
  $FlagsDtoCopyWith<$Res> get flagsDto;
}

/// @nodoc
class _$CountryDetailsCopyWithImpl<$Res, $Val extends CountryDetails>
    implements $CountryDetailsCopyWith<$Res> {
  _$CountryDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CountryDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cca2 = null,
    Object? nameDto = null,
    Object? flagsDto = null,
    Object? population = null,
    Object? capital = freezed,
    Object? region = null,
    Object? subregion = null,
    Object? area = null,
    Object? timezones = null,
  }) {
    return _then(
      _value.copyWith(
            cca2: null == cca2
                ? _value.cca2
                : cca2 // ignore: cast_nullable_to_non_nullable
                      as String,
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
            capital: freezed == capital
                ? _value.capital
                : capital // ignore: cast_nullable_to_non_nullable
                      as String?,
            region: null == region
                ? _value.region
                : region // ignore: cast_nullable_to_non_nullable
                      as String,
            subregion: null == subregion
                ? _value.subregion
                : subregion // ignore: cast_nullable_to_non_nullable
                      as String,
            area: null == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                      as double,
            timezones: null == timezones
                ? _value.timezones
                : timezones // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }

  /// Create a copy of CountryDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NameDtoCopyWith<$Res> get nameDto {
    return $NameDtoCopyWith<$Res>(_value.nameDto, (value) {
      return _then(_value.copyWith(nameDto: value) as $Val);
    });
  }

  /// Create a copy of CountryDetails
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
abstract class _$$CountryDetailsImplCopyWith<$Res>
    implements $CountryDetailsCopyWith<$Res> {
  factory _$$CountryDetailsImplCopyWith(
    _$CountryDetailsImpl value,
    $Res Function(_$CountryDetailsImpl) then,
  ) = __$$CountryDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String cca2,
    @JsonKey(name: 'name') NameDto nameDto,
    @JsonKey(name: 'flags') FlagsDto flagsDto,
    int population,
    @JsonKey(fromJson: _capitalFromJson) String? capital,
    String region,
    String subregion,
    double area,
    List<String> timezones,
  });

  @override
  $NameDtoCopyWith<$Res> get nameDto;
  @override
  $FlagsDtoCopyWith<$Res> get flagsDto;
}

/// @nodoc
class __$$CountryDetailsImplCopyWithImpl<$Res>
    extends _$CountryDetailsCopyWithImpl<$Res, _$CountryDetailsImpl>
    implements _$$CountryDetailsImplCopyWith<$Res> {
  __$$CountryDetailsImplCopyWithImpl(
    _$CountryDetailsImpl _value,
    $Res Function(_$CountryDetailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CountryDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cca2 = null,
    Object? nameDto = null,
    Object? flagsDto = null,
    Object? population = null,
    Object? capital = freezed,
    Object? region = null,
    Object? subregion = null,
    Object? area = null,
    Object? timezones = null,
  }) {
    return _then(
      _$CountryDetailsImpl(
        cca2: null == cca2
            ? _value.cca2
            : cca2 // ignore: cast_nullable_to_non_nullable
                  as String,
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
        capital: freezed == capital
            ? _value.capital
            : capital // ignore: cast_nullable_to_non_nullable
                  as String?,
        region: null == region
            ? _value.region
            : region // ignore: cast_nullable_to_non_nullable
                  as String,
        subregion: null == subregion
            ? _value.subregion
            : subregion // ignore: cast_nullable_to_non_nullable
                  as String,
        area: null == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as double,
        timezones: null == timezones
            ? _value._timezones
            : timezones // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CountryDetailsImpl extends _CountryDetails {
  const _$CountryDetailsImpl({
    this.cca2 = '',
    @JsonKey(name: 'name') required this.nameDto,
    @JsonKey(name: 'flags') required this.flagsDto,
    this.population = 0,
    @JsonKey(fromJson: _capitalFromJson) this.capital,
    this.region = '',
    this.subregion = '',
    this.area = 0.0,
    final List<String> timezones = const [],
  }) : _timezones = timezones,
       super._();

  factory _$CountryDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountryDetailsImplFromJson(json);

  @override
  @JsonKey()
  final String cca2;
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
  @JsonKey(fromJson: _capitalFromJson)
  final String? capital;
  @override
  @JsonKey()
  final String region;
  @override
  @JsonKey()
  final String subregion;
  @override
  @JsonKey()
  final double area;
  final List<String> _timezones;
  @override
  @JsonKey()
  List<String> get timezones {
    if (_timezones is EqualUnmodifiableListView) return _timezones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timezones);
  }

  @override
  String toString() {
    return 'CountryDetails(cca2: $cca2, nameDto: $nameDto, flagsDto: $flagsDto, population: $population, capital: $capital, region: $region, subregion: $subregion, area: $area, timezones: $timezones)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountryDetailsImpl &&
            (identical(other.cca2, cca2) || other.cca2 == cca2) &&
            (identical(other.nameDto, nameDto) || other.nameDto == nameDto) &&
            (identical(other.flagsDto, flagsDto) ||
                other.flagsDto == flagsDto) &&
            (identical(other.population, population) ||
                other.population == population) &&
            (identical(other.capital, capital) || other.capital == capital) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.subregion, subregion) ||
                other.subregion == subregion) &&
            (identical(other.area, area) || other.area == area) &&
            const DeepCollectionEquality().equals(
              other._timezones,
              _timezones,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    cca2,
    nameDto,
    flagsDto,
    population,
    capital,
    region,
    subregion,
    area,
    const DeepCollectionEquality().hash(_timezones),
  );

  /// Create a copy of CountryDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountryDetailsImplCopyWith<_$CountryDetailsImpl> get copyWith =>
      __$$CountryDetailsImplCopyWithImpl<_$CountryDetailsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CountryDetailsImplToJson(this);
  }
}

abstract class _CountryDetails extends CountryDetails {
  const factory _CountryDetails({
    final String cca2,
    @JsonKey(name: 'name') required final NameDto nameDto,
    @JsonKey(name: 'flags') required final FlagsDto flagsDto,
    final int population,
    @JsonKey(fromJson: _capitalFromJson) final String? capital,
    final String region,
    final String subregion,
    final double area,
    final List<String> timezones,
  }) = _$CountryDetailsImpl;
  const _CountryDetails._() : super._();

  factory _CountryDetails.fromJson(Map<String, dynamic> json) =
      _$CountryDetailsImpl.fromJson;

  @override
  String get cca2;
  @override
  @JsonKey(name: 'name')
  NameDto get nameDto;
  @override
  @JsonKey(name: 'flags')
  FlagsDto get flagsDto;
  @override
  int get population;
  @override
  @JsonKey(fromJson: _capitalFromJson)
  String? get capital;
  @override
  String get region;
  @override
  String get subregion;
  @override
  double get area;
  @override
  List<String> get timezones;

  /// Create a copy of CountryDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountryDetailsImplCopyWith<_$CountryDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
