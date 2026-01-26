import 'package:equatable/equatable.dart';
import '../../models/country_details.dart';

/// States for the country detail screen
abstract class CountryDetailState extends Equatable {
  const CountryDetailState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class CountryDetailInitial extends CountryDetailState {
  const CountryDetailInitial();
}

/// Loading state
class CountryDetailLoading extends CountryDetailState {
  const CountryDetailLoading();
}

/// Success state with country details
class CountryDetailLoaded extends CountryDetailState {
  final CountryDetails country;

  const CountryDetailLoaded(this.country);

  @override
  List<Object?> get props => [country];
}

/// Error state
class CountryDetailError extends CountryDetailState {
  final String message;

  const CountryDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
