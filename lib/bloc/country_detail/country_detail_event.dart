import 'package:equatable/equatable.dart';

/// Events for the country detail screen
abstract class CountryDetailEvent extends Equatable {
  const CountryDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Load country details by cca2 code
class LoadCountryDetail extends CountryDetailEvent {
  final String cca2;

  const LoadCountryDetail(this.cca2);

  @override
  List<Object?> get props => [cca2];
}

/// Retry loading country details
class RetryLoadCountryDetail extends CountryDetailEvent {
  final String cca2;

  const RetryLoadCountryDetail(this.cca2);

  @override
  List<Object?> get props => [cca2];
}
