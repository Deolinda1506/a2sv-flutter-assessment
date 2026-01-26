import 'package:equatable/equatable.dart';

/// Events for the countries list
abstract class CountriesEvent extends Equatable {
  const CountriesEvent();

  @override
  List<Object?> get props => [];
}

/// Load all countries
class LoadCountries extends CountriesEvent {
  const LoadCountries();
}

/// Search countries by name
class SearchCountries extends CountriesEvent {
  final String query;

  const SearchCountries(this.query);

  @override
  List<Object?> get props => [query];
}

/// Toggle favorite status
class ToggleFavorite extends CountriesEvent {
  final String cca2;

  const ToggleFavorite(this.cca2);

  @override
  List<Object?> get props => [cca2];
}

/// Refresh favorites
class RefreshFavorites extends CountriesEvent {
  const RefreshFavorites();
}
