import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/country_summary.dart';

/// Service for managing favorite countries with local persistence
class FavoritesService {
  static const String _favoritesKey = 'favorite_countries';

  /// Get all favorite country codes
  Future<Set<String>> getFavoriteCountryCodes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getString(_favoritesKey);
      if (favoritesJson == null) {
        return <String>{};
      }
      final List<dynamic> favoritesList = json.decode(favoritesJson);
      return favoritesList.map((e) => e.toString()).toSet();
    } catch (e) {
      return <String>{};
    }
  }

  /// Check if a country is favorited
  Future<bool> isFavorite(String cca2) async {
    final favorites = await getFavoriteCountryCodes();
    return favorites.contains(cca2);
  }

  /// Add a country to favorites
  Future<bool> addFavorite(String cca2) async {
    try {
      final favorites = await getFavoriteCountryCodes();
      favorites.add(cca2);
      return await _saveFavorites(favorites);
    } catch (e) {
      return false;
    }
  }

  /// Remove a country from favorites
  Future<bool> removeFavorite(String cca2) async {
    try {
      final favorites = await getFavoriteCountryCodes();
      favorites.remove(cca2);
      return await _saveFavorites(favorites);
    } catch (e) {
      return false;
    }
  }

  /// Toggle favorite status
  Future<bool> toggleFavorite(String cca2) async {
    final isFav = await isFavorite(cca2);
    if (isFav) {
      return await removeFavorite(cca2);
    } else {
      return await addFavorite(cca2);
    }
  }

  /// Save favorites to local storage
  Future<bool> _saveFavorites(Set<String> favorites) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = json.encode(favorites.toList());
      return await prefs.setString(_favoritesKey, favoritesJson);
    } catch (e) {
      return false;
    }
  }

  /// Get favorite countries with details (requires full country list)
  Future<List<CountrySummary>> getFavoriteCountries(
    List<CountrySummary> allCountries,
  ) async {
    final favoriteCodes = await getFavoriteCountryCodes();
    return allCountries
        .where((country) => favoriteCodes.contains(country.cca2))
        .toList();
  }
}
