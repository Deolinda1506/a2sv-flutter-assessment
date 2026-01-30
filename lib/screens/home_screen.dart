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
import '../widgets/theme_mode_button.dart';
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
    setState(() {}); // Rebuild to show/hide clear button
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
        title: Text(
          'Countries',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: [
          const ThemeModeButton(),
          BlocBuilder<CountriesBloc, CountriesState>(
            buildWhen: (prev, curr) =>
                prev is CountriesLoaded && curr is CountriesLoaded
                    ? prev.sortOption != curr.sortOption
                    : prev.runtimeType != curr.runtimeType,
            builder: (context, state) {
              final currentSort = state is CountriesLoaded
                  ? state.sortOption
                  : CountriesSortOption.populationDesc;
              return PopupMenuButton<CountriesSortOption>(
                icon: Icon(Icons.sort, color: Theme.of(context).colorScheme.onSurfaceVariant),
                onSelected: (option) {
                  context.read<CountriesBloc>().add(SetCountriesSort(option));
                },
                itemBuilder: (context) => [
                  PopupMenuItem<CountriesSortOption>(
                    value: CountriesSortOption.nameAsc,
                    child: Row(
                      children: [
                        if (currentSort == CountriesSortOption.nameAsc)
                          Icon(Icons.check, size: 20, color: Theme.of(context).colorScheme.primary),
                        if (currentSort == CountriesSortOption.nameAsc) const SizedBox(width: 8),
                        const Text('Name (A–Z)'),
                      ],
                    ),
                  ),
                  PopupMenuItem<CountriesSortOption>(
                    value: CountriesSortOption.nameDesc,
                    child: Row(
                      children: [
                        if (currentSort == CountriesSortOption.nameDesc)
                          Icon(Icons.check, size: 20, color: Theme.of(context).colorScheme.primary),
                        if (currentSort == CountriesSortOption.nameDesc) const SizedBox(width: 8),
                        const Text('Name (Z–A)'),
                      ],
                    ),
                  ),
                  PopupMenuItem<CountriesSortOption>(
                    value: CountriesSortOption.populationDesc,
                    child: Row(
                      children: [
                        if (currentSort == CountriesSortOption.populationDesc)
                          Icon(Icons.check, size: 20, color: Theme.of(context).colorScheme.primary),
                        if (currentSort == CountriesSortOption.populationDesc) const SizedBox(width: 8),
                        const Text('Population (High → Low)'),
                      ],
                    ),
                  ),
                ],
              );
            },
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
                  hintText: 'Search for a country.',
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              _searchController.clear();
                              _onSearchChanged('');
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.cancel,
                                size: 20,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        )
                      : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No countries found.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  final crossAxisCount = listGridCrossAxisCount(context);
                  return RefreshIndicator(
                    onRefresh: () async {
                      final bloc = context.read<CountriesBloc>();
                      final completer = Completer<void>();
                      StreamSubscription<CountriesState>? sub;
                      void listener(CountriesState state) {
                        if (state is CountriesLoaded || state is CountriesError) {
                          sub?.cancel();
                          if (!completer.isCompleted) completer.complete();
                        }
                      }
                      sub = bloc.stream.listen(listener);
                      final query = _searchController.text.trim();
                      if (query.isEmpty) {
                        bloc.add(const LoadCountries(fromUser: true));
                      } else {
                        bloc.add(SearchCountries(query));
                      }
                      await completer.future;
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
