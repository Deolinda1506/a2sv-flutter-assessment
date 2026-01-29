import 'package:get_it/get_it.dart';

import '../services/countries_api_service.dart';
import '../services/favorites_service.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  if (getIt.isRegistered<CountriesApiService>()) return;

  getIt.registerLazySingleton<CountriesApiService>(() => CountriesApiService());
  getIt.registerLazySingleton<FavoritesService>(() => FavoritesService());
}

