import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/countries/countries_bloc.dart';
import '../bloc/countries/countries_event.dart';
import '../bloc/countries/countries_state.dart';
import '../bloc/countries/countries_sort.dart';
import '../utils/layout.dart';
import '../widgets/country_list_item.dart';
import '../widgets/shimmer_loader.dart';
import 'country_detail_screen.dart';

/// Home screen displaying list of countries with search functionality
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    // Load countries when screen initializes
    context.read<CountriesBloc>().add(const LoadCountries());
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      context.read<CountriesBloc>().add(SearchCountries(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Countries',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton<CountriesSortOption>(
            icon: const Icon(Icons.sort),
            onSelected: (option) {
              context.read<CountriesBloc>().add(SetCountriesSort(option));
            },
            itemBuilder: (context) => const [
              PopupMenuItem<CountriesSortOption>(
                value: CountriesSortOption.nameAsc,
                child: Text('Sort: Name (A–Z)'),
              ),
              PopupMenuItem<CountriesSortOption>(
                value: CountriesSortOption.populationDesc,
                child: Text('Sort: Population (High → Low)'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Semantics(
              label: 'Search for a country',
              hint: 'Filters the list as you type',
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search for a country',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                        )
                      : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue[300]!),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          ),
          // Countries list
          Expanded(
            child: BlocBuilder<CountriesBloc, CountriesState>(
              builder: (context, state) {
                if (state is CountriesLoading) {
                  return const CountryListShimmer();
                } else if (state is CountriesError) {
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
                          state.message,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<CountriesBloc>().add(const LoadCountries());
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (state is CountriesLoaded) {
                  if (state.countries.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No countries found.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  final crossAxisCount = listGridCrossAxisCount(context);
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<CountriesBloc>().add(const LoadCountries());
                    },
                    child: crossAxisCount == 1
                        ? ListView.builder(
                            itemCount: state.countries.length,
                            itemBuilder: (context, index) =>
                                _buildCountryItem(context, state, index),
                          )
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: 2.2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            padding: const EdgeInsets.all(8),
                            itemCount: state.countries.length,
                            itemBuilder: (context, index) =>
                                _buildCountryItem(context, state, index),
                          ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryItem(
    BuildContext context,
    CountriesLoaded state,
    int index,
  ) {
    final country = state.countries[index];
    return CountryListItem(
      country: country,
      isFavorite: state.isFavorite(country.cca2),
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
      onFavoriteTap: () {
        context.read<CountriesBloc>().add(ToggleFavorite(country.cca2));
      },
    );
  }
}
