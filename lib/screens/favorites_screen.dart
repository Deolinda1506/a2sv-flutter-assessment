import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/countries/countries_bloc.dart';
import '../bloc/countries/countries_event.dart';
import '../services/countries_api_service.dart';
import '../services/favorites_service.dart';
import '../models/country_summary.dart';
import 'country_detail_screen.dart';

/// Screen displaying list of favorite countries
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesService _favoritesService = FavoritesService();
  final CountriesApiService _apiService = CountriesApiService();
  Map<String, String?> _favoriteCapitals = {}; // cca2 -> capital
  List<CountrySummary> _favoriteCountries = [];
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
      // Get all countries first
      final allCountries = await _apiService.getAllCountries();
      // Get favorite countries
      final favorites = await _favoritesService.getFavoriteCountries(allCountries);
      
      // Fetch capitals for favorite countries
      final Map<String, String?> capitals = {};
      for (final country in favorites) {
        try {
          final details = await _apiService.getCountryDetails(country.cca2);
          capitals[country.cca2] = details.capital;
        } catch (e) {
          capitals[country.cca2] = null;
        }
      }
      
      setState(() {
        _favoriteCountries = favorites;
        _favoriteCapitals = capitals;
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
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
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
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              _error!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
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
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No favorites yet.\nAdd countries to favorites from the Home screen.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _favoriteCountries.length,
      itemBuilder: (context, index) {
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
              children: [
                // Flag
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    country.flagPng,
                    width: 56,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 56,
                        height: 40,
                        color: Colors.grey[300],
                        child: const Icon(Icons.flag, size: 24),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // Country name and capital
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        country.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _favoriteCapitals[country.cca2] != null
                            ? 'Capital: ${_favoriteCapitals[country.cca2]}'
                            : 'Population: ${country.formattedPopulation}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                // Favorite icon
                IconButton(
                  onPressed: () => _toggleFavorite(country.cca2),
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
