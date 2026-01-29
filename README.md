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

## Design Decisions

The app is built around a few deliberate choices to balance clarity, performance, and maintainability:

- **BLoC over other state management**: Keeps business logic out of the UI and makes flows (load → loading/loaded/error) explicit and testable. Events and states are plain Dart classes, so unit testing the bloc does not depend on the widget tree.
- **Two-step API usage**: List screens request only `name`, `flags`, `population`, and `cca2` to keep payloads small and fast. Full details (capital, region, area, timezones) are fetched only when the user opens a country, reducing data transfer and improving perceived performance.
- **get_it as service locator**: Services (API, favorites) and their dependencies are registered in one place (`di/service_locator.dart`). Screens and blocs get them via `getIt()`, which simplifies testing with fakes and keeps constructors consistent.
- **Freezed + json_serializable for models**: Immutable DTOs with generated `copyWith`, `==`, and JSON parsing keep the domain layer consistent and reduce boilerplate and parsing bugs.

These choices support automated testing, accessibility (Semantics on key actions), and responsive layout (breakpoints, rail, grid) without over-engineering for the scope.

## Technology & Architecture Choices

### State Management: BLoC Pattern
- **Why BLoC?**: Clear separation of business logic from UI; testable and maintainable
- **Implementation**: `flutter_bloc` with distinct events and states per feature

### HTTP Client: Dio
- **Why Dio?**: Interceptors, better error handling, and request/response transformation
- **Implementation**: `CountriesApiService` with loading/success/error handling

### Local Storage: SharedPreferences
- **Why SharedPreferences?**: Simple key-value storage for favorite country codes
- **Implementation**: `FavoritesService` for add/remove/toggle with persistence

### Data Models: Freezed + json_serializable
- **Why?**: Immutable models, generated equality and JSON parsing, less boilerplate
- **Implementation**: `CountrySummary`, `CountryDetails`, nested DTOs; regenerate with `build_runner`

### Two-Step Data Fetching Strategy
- **Step 1**: Fetch minimal data (name, flags, population, cca2) for lists to improve performance
- **Step 2**: Fetch full details (including capital, area, timezones) only when viewing country details

## Setup Instructions

### Prerequisites
- Flutter SDK (3.10.1 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- An internet connection (for API calls)

**Environment variables:** None required. The app uses the public REST Countries API.

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

### Before submission (best practices)

- **No secrets:** Keep the project as-is: no `.env` with keys, no hardcoded secrets. The app uses the public REST Countries API only.
- **After adding a dependency:** Run `flutter pub get` and then `flutter run` or `flutter build apk --release`, and fix any errors before considering the project done.
- **After regenerating code:** If you run `dart run build_runner build --delete-conflicting-outputs`, run `flutter test` and a quick manual test afterward. Don’t commit half-regenerated code.

## API Usage

This app uses the [REST Countries API](https://restcountries.com/):
- Base URL: `https://restcountries.com/v3.1`
- All API calls are made using the two-step fetching strategy as specified in the requirements

## Testing

- **Unit tests**: `CountriesBloc` (load, search, sort, error) and `FavoritesService` (add, remove, toggle) with fakes/mocks
- **Widget test**: App boots and shows Home tab
- Run: `flutter test`

## Accessibility

- **Semantics** on main actions: search field (label + hint), country list items (name + population + “double tap to view details”), favorite button (“Add/Remove … from favorites”), detail Retry button
- Supports screen readers and focus order

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
