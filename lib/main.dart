import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/main_screen.dart';
import 'bloc/countries/countries_bloc.dart';
import 'bloc/countries/countries_event.dart';
import 'di/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure service locator is available (useful for tests that pump MyApp directly).
    setupServiceLocator();

    return MaterialApp(
      title: 'Countries App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: BlocProvider(
        create: (context) => CountriesBloc(
          apiService: getIt(),
          favoritesService: getIt(),
        )..add(const LoadCountries()),
        child: const MainScreen(),
      ),
    );
  }
}
