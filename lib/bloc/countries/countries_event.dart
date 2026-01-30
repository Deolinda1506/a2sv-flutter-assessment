import 'package:equatable/equatable.dart';
import 'countries_sort.dart';

/// Events for the countries list
abstract class CountriesEvent extends Equatable {
  const CountriesEvent();

  @override
  List<Object?> get props => [];
}

/// Load all countries
class LoadCountries extends CountriesEvent {
  /// When true, always emit (e.g. user pulled to refresh or cleared search).
  /// When false (e.g. initial load), do not overwrite if we're already showing search results.
  final bool fromUser;

  const LoadCountries({this.fromUser = false});

  @override
  List<Object?> get props => [fromUser];
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

/// Change sorting for the countries list
class SetCountriesSort extends CountriesEvent {
  final CountriesSortOption sortOption;

  const SetCountriesSort(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}
