import 'package:dio/dio.dart';
import '../models/country_details.dart';
import '../models/country_summary.dart';

/// Service for interacting with the REST Countries API
class CountriesApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://restcountries.com/v3.1';

  CountriesApiService({Dio? dio}) : _dio = dio ?? Dio();

  /// Fetch all countries with minimal data for lists
  /// Returns only: name, flags, population, cca2
  Future<List<CountrySummary>> getAllCountries() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/all',
        queryParameters: {
          'fields': 'name,flags,population,cca2',
        },
      );

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => CountrySummary.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      throw Exception('Failed to load countries');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Search countries by name with minimal data for lists
  /// Returns only: name, flags, population, cca2
  Future<List<CountrySummary>> searchCountriesByName(String name) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/name/$name',
        queryParameters: {
          'fields': 'name,flags,population,cca2',
        },
      );

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => CountrySummary.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      throw Exception('Failed to search countries');
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return []; // No countries found
      }
      throw _handleError(e);
    }
  }

  /// Fetch detailed country data by cca2 code
  /// Returns: name, flags, population, capital, region, subregion, area, timezones
  Future<CountryDetails> getCountryDetails(String cca2) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/alpha/$cca2',
        queryParameters: {
          'fields':
              'cca2,name,flags,population,capital,region,subregion,area,timezones',
        },
      );

      if (response.statusCode == 200 && response.data is Map) {
        return CountryDetails.fromJson(response.data as Map<String, dynamic>);
      }
      throw Exception('Failed to load country details');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Handle Dio errors and convert to user-friendly messages
  Exception _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return Exception('Connection timeout. Please check your internet connection.');
    } else if (error.type == DioExceptionType.connectionError) {
      return Exception('No internet connection. Please check your network.');
    } else if (error.response != null) {
      return Exception('Server error: ${error.response?.statusCode}');
    }
    return Exception('An unexpected error occurred. Please try again.');
  }
}
