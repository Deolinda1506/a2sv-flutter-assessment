import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/countries_api_service.dart';
import '../../services/favorites_service.dart';
import 'countries_event.dart';
import 'countries_state.dart';

/// BLoC for managing countries list state
class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final CountriesApiService _apiService;
  final FavoritesService _favoritesService;

  CountriesBloc({
    required CountriesApiService apiService,
    required FavoritesService favoritesService,
  })  : _apiService = apiService,
        _favoritesService = favoritesService,
        super(const CountriesInitial()) {
    on<LoadCountries>(_onLoadCountries);
    on<SearchCountries>(_onSearchCountries);
    on<ToggleFavorite>(_onToggleFavorite);
    on<RefreshFavorites>(_onRefreshFavorites);
  }

  Future<void> _onLoadCountries(
    LoadCountries event,
    Emitter<CountriesState> emit,
  ) async {
    emit(const CountriesLoading());
    try {
      final countries = await _apiService.getAllCountries();
      final favoriteCodes = await _favoritesService.getFavoriteCountryCodes();
      emit(CountriesLoaded(
        countries: countries,
        favoriteCountryCodes: favoriteCodes,
      ));
    } catch (e) {
      emit(CountriesError(e.toString()));
    }
  }

  Future<void> _onSearchCountries(
    SearchCountries event,
    Emitter<CountriesState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(const LoadCountries());
      return;
    }

    emit(const CountriesLoading());
    try {
      final countries = await _apiService.searchCountriesByName(event.query);
      final favoriteCodes = await _favoritesService.getFavoriteCountryCodes();
      emit(CountriesLoaded(
        countries: countries,
        favoriteCountryCodes: favoriteCodes,
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
      ));
    }
  }
}
