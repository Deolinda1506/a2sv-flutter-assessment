import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/country_summary.dart';
import '../../services/countries_api_service.dart';
import '../../services/favorites_service.dart';
import 'countries_event.dart';
import 'countries_sort.dart';
import 'countries_state.dart';

/// BLoC for managing countries list state
class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final CountriesApiService _apiService;
  final FavoritesService _favoritesService;
  CountriesSortOption _sortOption = CountriesSortOption.populationDesc;

  CountriesBloc({
    required CountriesApiService apiService,
    required FavoritesService favoritesService,
  })  : _apiService = apiService,
        _favoritesService = favoritesService,
        super(const CountriesInitial()) {
    on<LoadCountries>(_onLoadCountries, transformer: concurrent());
    on<SearchCountries>(_onSearchCountries, transformer: concurrent());
    on<ToggleFavorite>(_onToggleFavorite);
    on<RefreshFavorites>(_onRefreshFavorites);
    on<SetCountriesSort>(_onSetCountriesSort);
  }

  /// Normalize name for alphabetical sort so Å, Ä, Ö etc. sort with A, A, O (Z–A then shows Z before A).
  static String _nameSortKey(String name) {
    const accents = 'àáâãäåæçèéêëìíîïñòóôõöøùúûüýÿ';
    const ascii = 'aaaaaaaceeeeiiiinoooooouuuuyy';
    String s = name.toLowerCase();
    for (int i = 0; i < accents.length; i++) {
      s = s.replaceAll(accents[i], ascii[i]);
    }
    return s;
  }

  List<CountrySummary> _applySort(List<CountrySummary> countries) {
    final sorted = [...countries];
    switch (_sortOption) {
      case CountriesSortOption.nameAsc:
        sorted.sort((a, b) => _nameSortKey(a.name).compareTo(_nameSortKey(b.name)));
        break;
      case CountriesSortOption.nameDesc:
        sorted.sort((a, b) => _nameSortKey(b.name).compareTo(_nameSortKey(a.name)));
        break;
      case CountriesSortOption.populationDesc:
        sorted.sort((a, b) => b.population.compareTo(a.population));
        break;
    }
    return sorted;
  }

  Future<void> _onLoadCountries(
    LoadCountries event,
    Emitter<CountriesState> emit,
  ) async {
    emit(const CountriesLoading());
    try {
      final countries = _applySort(await _apiService.getAllCountries());
      final favoriteCodes = await _favoritesService.getFavoriteCountryCodes();
      // If this was the initial load (not from user) and we're already showing search results, don't overwrite
      if (!event.fromUser && state is CountriesLoaded && (state as CountriesLoaded).isSearchResult) {
        return;
      }
      emit(CountriesLoaded(
        countries: countries,
        favoriteCountryCodes: favoriteCodes,
        sortOption: _sortOption,
        isSearchResult: false,
      ));
    } catch (e) {
      emit(CountriesError(e.toString()));
    }
  }

  Future<void> _onSearchCountries(
    SearchCountries event,
    Emitter<CountriesState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      add(const LoadCountries(fromUser: true));
      return;
    }

    emit(const CountriesLoading());
    try {
      final countries =
          _applySort(await _apiService.searchCountriesByName(query));
      final favoriteCodes = await _favoritesService.getFavoriteCountryCodes();
      emit(CountriesLoaded(
        countries: countries,
        favoriteCountryCodes: favoriteCodes,
        sortOption: _sortOption,
        isSearchResult: true,
      ));
    } catch (e) {
      emit(CountriesError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<CountriesState> emit,
  ) async {
    if (state is CountriesLoaded) {
      final currentState = state as CountriesLoaded;
      await _favoritesService.toggleFavorite(event.cca2);
      final favoriteCodes = await _favoritesService.getFavoriteCountryCodes();
      emit(CountriesLoaded(
        countries: currentState.countries,
        favoriteCountryCodes: favoriteCodes,
        sortOption: currentState.sortOption,
        isSearchResult: currentState.isSearchResult,
      ));
    }
  }

  Future<void> _onRefreshFavorites(
    RefreshFavorites event,
    Emitter<CountriesState> emit,
  ) async {
    if (state is CountriesLoaded) {
      final currentState = state as CountriesLoaded;
      final favoriteCodes = await _favoritesService.getFavoriteCountryCodes();
      emit(CountriesLoaded(
        countries: currentState.countries,
        favoriteCountryCodes: favoriteCodes,
        sortOption: currentState.sortOption,
      ));
    }
  }

  Future<void> _onSetCountriesSort(
    SetCountriesSort event,
    Emitter<CountriesState> emit,
  ) async {
    _sortOption = event.sortOption;
    if (state is CountriesLoaded) {
      final currentState = state as CountriesLoaded;
      emit(CountriesLoaded(
        countries: _applySort(currentState.countries),
        favoriteCountryCodes: currentState.favoriteCountryCodes,
        sortOption: _sortOption,
        isSearchResult: currentState.isSearchResult,
      ));
    } else {
      add(const LoadCountries());
    }
  }
}
