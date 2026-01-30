import 'package:equatable/equatable.dart';
import '../../models/country_summary.dart';
import 'countries_sort.dart';

/// States for the countries list
abstract class CountriesState extends Equatable {
  const CountriesState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class CountriesInitial extends CountriesState {
  const CountriesInitial();
}

/// Loading state
class CountriesLoading extends CountriesState {
  const CountriesLoading();
}

/// Success state with countries list
class CountriesLoaded extends CountriesState {
  final List<CountrySummary> countries;
  final Set<String> favoriteCountryCodes;
  final CountriesSortOption sortOption;
  /// True when this list is from a search (so initial LoadCountries should not overwrite it).
  final bool isSearchResult;

  const CountriesLoaded({
    required this.countries,
    required this.favoriteCountryCodes,
    this.sortOption = CountriesSortOption.populationDesc,
    this.isSearchResult = false,
  });

  @override
  List<Object?> get props => [countries, favoriteCountryCodes, sortOption, isSearchResult];

  /// Check if a country is favorited
  bool isFavorite(String cca2) {
    return favoriteCountryCodes.contains(cca2);
  }
}

/// Error state
class CountriesError extends CountriesState {
  final String message;

  const CountriesError(this.message);

  @override
  List<Object?> get props => [message];
}
