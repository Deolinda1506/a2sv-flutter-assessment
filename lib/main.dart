import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/main_screen.dart';
import 'bloc/countries/countries_bloc.dart';
import 'bloc/countries/countries_event.dart';
import 'di/service_locator.dart';
import 'utils/theme_mode_scope.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<ThemeMode> _themeModeNotifier = ValueNotifier(ThemeMode.system);

  void _onThemeModeChanged() => setState(() {});

  @override
  void initState() {
    super.initState();
    _themeModeNotifier.addListener(_onThemeModeChanged);
  }

  @override
  void dispose() {
    _themeModeNotifier.removeListener(_onThemeModeChanged);
    _themeModeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setupServiceLocator();

    return ThemeModeScope(
      themeModeNotifier: _themeModeNotifier,
      child: MaterialApp(
        title: 'Countries App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 0,
            centerTitle: true,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ).surface,
          appBarTheme: AppBarTheme(
            backgroundColor: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ).surface,
            foregroundColor: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ).onSurface,
            elevation: 0,
            centerTitle: true,
          ),
        ),
        themeMode: _themeModeNotifier.value,
        home: BlocProvider(
          create: (context) => CountriesBloc(
            apiService: getIt(),
            favoritesService: getIt(),
          )..add(const LoadCountries()),
          child: const MainScreen(),
        ),
      ),
    );
  }
}
