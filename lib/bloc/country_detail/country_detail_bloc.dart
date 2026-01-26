import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/countries_api_service.dart';
import 'country_detail_event.dart';
import 'country_detail_state.dart';

/// BLoC for managing country detail state
class CountryDetailBloc extends Bloc<CountryDetailEvent, CountryDetailState> {
  final CountriesApiService _apiService;

  CountryDetailBloc({required CountriesApiService apiService})
      : _apiService = apiService,
        super(const CountryDetailInitial()) {
    on<LoadCountryDetail>(_onLoadCountryDetail);
    on<RetryLoadCountryDetail>(_onRetryLoadCountryDetail);
  }

  Future<void> _onLoadCountryDetail(
    LoadCountryDetail event,
    Emitter<CountryDetailState> emit,
  ) async {
    emit(const CountryDetailLoading());
    try {
      final country = await _apiService.getCountryDetails(event.cca2);
      emit(CountryDetailLoaded(country));
    } catch (e) {
      emit(CountryDetailError(e.toString()));
    }
  }

  Future<void> _onRetryLoadCountryDetail(
    RetryLoadCountryDetail event,
    Emitter<CountryDetailState> emit,
  ) async {
    add(LoadCountryDetail(event.cca2));
  }
}
