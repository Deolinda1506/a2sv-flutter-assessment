import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:countries_app/bloc/countries/countries_bloc.dart';
import 'package:countries_app/bloc/countries/countries_event.dart';
import 'package:countries_app/bloc/countries/countries_sort.dart';
import 'package:countries_app/bloc/countries/countries_state.dart';
import 'package:countries_app/models/country_summary.dart';
import 'package:countries_app/services/countries_api_service.dart';
import 'package:countries_app/services/favorites_service.dart';

/// Fake API that returns a fixed list for tests
class FakeCountriesApiService extends CountriesApiService {
  final List<CountrySummary> countries;
  final bool shouldFail;

  FakeCountriesApiService({required this.countries, this.shouldFail = false})
      : super();

  @override
  Future<List<CountrySummary>> getAllCountries() async {
    if (shouldFail) throw Exception('Network error');
    return countries;
  }

  @override
  Future<List<CountrySummary>> searchCountriesByName(String name) async {
    if (shouldFail) throw Exception('Network error');
    if (name.isEmpty) return countries;
    return countries.where((c) => c.name.toLowerCase().contains(name.toLowerCase())).toList();
  }
}

/// Fake favorites service using in-memory set
class FakeFavoritesService extends FavoritesService {
  final Set<String> _codes = {};

  Set<String> get currentCodes => Set.from(_codes);

  @override
  Future<Set<String>> getFavoriteCountryCodes() async => Set.from(_codes);

  @override
  Future<bool> addFavorite(String cca2) async {
    _codes.add(cca2);
    return true;
  }

  @override
  Future<bool> removeFavorite(String cca2) async {
    _codes.remove(cca2);
    return true;
  }

  @override
  Future<bool> toggleFavorite(String cca2) async {
    if (_codes.contains(cca2)) {
      _codes.remove(cca2);
    } else {
      _codes.add(cca2);
    }
    return true;
  }
}

CountrySummary _country(String name, String cca2, int population) {
  return CountrySummary(
    nameDto: NameDto(common: name),
    flagsDto: const FlagsDto(png: 'https://flag.png', svg: 'https://flag.svg'),
    population: population,
    cca2: cca2,
  );
}

void main() {
  late CountriesBloc bloc;
  late FakeCountriesApiService api;
  late FakeFavoritesService favorites;

  final sampleCountries = [
    _country('Ethiopia', 'ET', 120000000),
    _country('Kenya', 'KE', 54000000),
    _country('Nigeria', 'NG', 220000000),
  ];

  setUp(() {
    api = FakeCountriesApiService(countries: sampleCountries);
    favorites = FakeFavoritesService();
    bloc = CountriesBloc(apiService: api, favoritesService: favorites);
  });

  tearDown(() => bloc.close());

  group('CountriesBloc', () {
    test('initial state is CountriesInitial', () {
      expect(bloc.state, isA<CountriesInitial>());
    });

    blocTest<CountriesBloc, CountriesState>(
      'LoadCountries emits Loading then Loaded with countries',
      build: () => bloc,
      act: (b) => b.add(const LoadCountries()),
      expect: () => [
        isA<CountriesLoading>(),
        isA<CountriesLoaded>().having(
          (s) => s.countries.length,
          'countries.length',
          3,
        ),
      ],
    );

    blocTest<CountriesBloc, CountriesState>(
      'LoadCountries on API failure emits Loading then Error',
      build: () {
        final failApi = FakeCountriesApiService(
          countries: sampleCountries,
          shouldFail: true,
        );
        return CountriesBloc(apiService: failApi, favoritesService: favorites);
      },
      act: (b) => b.add(const LoadCountries()),
      expect: () => [
        isA<CountriesLoading>(),
        isA<CountriesError>(),
      ],
    );

    blocTest<CountriesBloc, CountriesState>(
      'SearchCountries with empty query adds LoadCountries',
      build: () => bloc,
      act: (b) => b.add(const SearchCountries('')),
      expect: () => [
        isA<CountriesLoading>(),
        isA<CountriesLoaded>(),
      ],
    );

    blocTest<CountriesBloc, CountriesState>(
      'SetCountriesSort when loaded reorders by population',
      build: () => bloc,
      seed: () => CountriesLoaded(
        countries: sampleCountries,
        favoriteCountryCodes: {},
        sortOption: CountriesSortOption.nameAsc,
      ),
      act: (b) => b.add(const SetCountriesSort(CountriesSortOption.populationDesc)),
      expect: () => [
        isA<CountriesLoaded>().having(
          (s) => s.countries.first.name,
          'first country name',
          'Nigeria',
        ),
      ],
    );
  });
}
