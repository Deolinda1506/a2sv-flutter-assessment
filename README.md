# Countries App

A Flutter mobile application for browsing and exploring countries using the REST Countries API. Built for A2SV Technical Assessment.

## Features

- **Browse Countries**: View a scrollable list of all countries with flags, names, and population
- **Search**: Real-time search functionality to find countries by name
- **Country Details**: View detailed information including area, population, region, subregion, and timezones
- **Favorites**: Mark countries as favorites and access them later with local persistence
- **Loading States**: Shimmer effects during data loading
- **Error Handling**: User-friendly error messages with retry functionality

## Project Structure

```
lib/
├── bloc/                    # State management (BLoC pattern)
│   ├── countries/          # Countries list BLoC
│   └── country_detail/     # Country detail BLoC
├── models/                  # Data models
│   ├── country_summary.dart
│   └── country_details.dart
├── screens/                 # UI screens
│   ├── home_screen.dart
│   ├── country_detail_screen.dart
│   ├── favorites_screen.dart
│   └── main_screen.dart
├── services/                # Business logic services
│   ├── countries_api_service.dart
│   └── favorites_service.dart
├── widgets/                 # Reusable widgets
│   ├── country_list_item.dart
│   └── shimmer_loader.dart
└── main.dart               # App entry point
```

## Technology & Architecture Choices

### State Management: BLoC Pattern
- **Why BLoC?**: Provides clear separation of business logic from UI, making the code testable and maintainable
- **Implementation**: Used `flutter_bloc` package with Cubit pattern for simpler state management

### HTTP Client: Dio
- **Why Dio?**: More features than the standard `http` package, including interceptors, better error handling, and request/response transformation
- **Implementation**: Custom `CountriesApiService` with proper error handling

### Local Storage: SharedPreferences
- **Why SharedPreferences?**: Simple key-value storage perfect for storing favorite country codes
- **Implementation**: `FavoritesService` handles all favorite operations with persistence

### Data Models: Equatable
- **Why Equatable?**: Provides value equality for immutable data models, essential for BLoC state comparisons
- **Implementation**: All models extend `Equatable` for proper state management

### Two-Step Data Fetching Strategy
- **Step 1**: Fetch minimal data (name, flags, population, cca2) for lists to improve performance
- **Step 2**: Fetch full details (including capital, area, timezones) only when viewing country details

## Setup Instructions

### Prerequisites
- Flutter SDK (3.10.1 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- An internet connection (for API calls)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Deolinda1506/a2sv-flutter-assessment.git
   cd a2sv-flutter-assessment
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building APK

To build an APK for Android:

```bash
flutter build apk --release
```

The APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

## API Usage

This app uses the [REST Countries API](https://restcountries.com/):
- Base URL: `https://restcountries.com/v3.1`
- All API calls are made using the two-step fetching strategy as specified in the requirements

## User Stories Implemented

✅ **User Story 1**: View a List of All Countries
- Scrollable list with flags, names, and formatted population
- Loading shimmer effect
- Error state with retry option

✅ **User Story 2**: Search for a Specific Country
- Real-time search as user types
- Empty state when no results found

✅ **User Story 3**: View Detailed Information About a Country
- Navigation to detail screen on tap
- Separate API call for full details using cca2 code
- Displays flag, key statistics, and timezones
- Loading and error states

✅ **User Story 4**: Manage a List of Favorite Countries
- Heart icon to toggle favorites
- Local persistence with SharedPreferences
- Favorites screen with capital display
- Empty state when no favorites

## Bonus Features Implemented

- **Hero animation** – Flag animates from list to detail screen
- **Dark mode** – Follows system theme
- **Pull-to-refresh** – On Home screen list
- **Search debouncing** – 300 ms to reduce API calls
- **Data caching** – Country details cached in memory + SharedPreferences (offline fallback)
- **Dependency injection** – `get_it` service locator
- **Sorting** – Name (A–Z) and Population (high → low) on Home
- **Tablet/Web support** – Responsive layout:
  - **≥600 px**: Navigation rail instead of bottom bar; country list as 2-column grid
  - **≥900 px**: 3-column grid for countries
  - Favorites screen uses the same grid on larger widths
- **Code generation** – `freezed` for immutable data models and `json_serializable` for JSON parsing (`CountrySummary`, `CountryDetails`, plus nested `NameDto`/`FlagsDto` for API shape). Regenerate with: `dart run build_runner build --delete-conflicting-outputs`

## Dependencies

- `flutter_bloc: ^8.1.6` - State management
- `dio: ^5.4.0` - HTTP client
- `shared_preferences: ^2.2.2` - Local storage
- `equatable: ^2.0.5` - Value equality (BLoC states)
- `freezed_annotation` / `json_annotation` - Data models and JSON
- `shimmer: ^3.0.0` - Loading shimmer effects
- `get_it: ^9.2.0` - Service locator / dependency injection

### Dev

- `build_runner`, `freezed`, `json_serializable` - Code generation for models

## License

MIT License
