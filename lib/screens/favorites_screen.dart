import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/countries/countries_bloc.dart';
import '../bloc/countries/countries_event.dart';
import '../di/service_locator.dart';
import '../models/country_details.dart';
import '../services/countries_api_service.dart';
import '../services/favorites_service.dart';
import '../utils/layout.dart';
import '../widgets/theme_mode_button.dart';
import 'country_detail_screen.dart';

/// Screen displaying list of favorite countries
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  final _favoritesService = getIt.get<FavoritesService>();
  final _apiService = getIt.get<CountriesApiService>();
  List<CountryDetails> _favoriteCountries = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void refresh() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final favoriteCodes = await _favoritesService.getFavoriteCountryCodes();

      if (favoriteCodes.isEmpty) {
        setState(() {
          _favoriteCountries = [];
          _isLoading = false;
        });
        return;
      }

      // Fetch details in parallel (includes capital)
      final favorites = await Future.wait(
        favoriteCodes.map(_apiService.getCountryDetails),
      );

      setState(() {
        _favoriteCountries = favorites;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleFavorite(String cca2) async {
    await _favoritesService.toggleFavorite(cca2);
    // Refresh favorites list
    await _loadFavorites();
    // Also refresh the countries bloc if it exists
    if (mounted) {
      context.read<CountriesBloc>().add(const RefreshFavorites());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: const [ThemeModeButton()],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              _error!,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadFavorites,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_favoriteCountries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No favorites yet.\nAdd countries to favorites from the Home screen.',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final crossAxisCount = listGridCrossAxisCount(context);
    if (crossAxisCount == 1) {
      return ListView.builder(
        itemCount: _favoriteCountries.length,
        itemBuilder: (context, index) => _buildFavoriteItem(context, index),
      );
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 2.2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      padding: const EdgeInsets.all(8),
      itemCount: _favoriteCountries.length,
      itemBuilder: (context, index) => _buildFavoriteItem(context, index),
    );
  }

  Widget _buildFavoriteItem(BuildContext context, int index) {
    final country = _favoriteCountries[index];
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CountryDetailScreen(
              cca2: country.cca2,
              countryName: country.name,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Column 1: flags (fixed width so all flags align)
            SizedBox(
              width: 56,
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: country.flagPng.isEmpty
                      ? Container(
                          width: 56,
                          height: 40,
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          child: Icon(Icons.flag, size: 24, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        )
                      : Image.network(
                          country.flagPng,
                          width: 56,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 56,
                              height: 40,
                              color: Theme.of(context).colorScheme.surfaceContainerHighest,
                              child: Icon(Icons.flag, size: 24, color: Theme.of(context).colorScheme.onSurfaceVariant),
                            );
                          },
                        ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Column 2: name + capital/population (takes remaining space so names align)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    country.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    country.capital != null && country.capital!.isNotEmpty
                        ? 'Capital: ${country.capital}'
                        : 'Population: ${country.formattedPopulation}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Column 3: hearts (fixed width so all hearts align on the right)
            SizedBox(
              width: 48,
              height: 48,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => _toggleFavorite(country.cca2),
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
