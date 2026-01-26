import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/main_screen.dart';
import 'bloc/countries/countries_bloc.dart';
import 'services/countries_api_service.dart';
import 'services/favorites_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize services
    final apiService = CountriesApiService();
    final favoritesService = FavoritesService();

    return MaterialApp(
      title: 'Countries App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BlocProvider(
        create: (context) => CountriesBloc(
          apiService: apiService,
          favoritesService: favoritesService,
        )..add(const LoadCountries()),
        child: const MainScreen(),
      ),
    );
  }
}
