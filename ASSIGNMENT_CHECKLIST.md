# A2SV Countries App – Assignment Checklist

Overall verification against the full assignment brief (Technical Interview, Mobile).

**Last check:** All requirements verified against brief. `flutter test` — **11 tests passed.**

---

## Objective & Project Overview

| Requirement | Status |
|-------------|--------|
| Flutter mobile app for browsing, searching, learning about countries | ✅ |
| Fetch data from public API | ✅ REST Countries API |
| Manage application state efficiently | ✅ BLoC |
| Faithful to design mockups | ✅ Figma-aligned (recent pass) |
| API integration, state management, local storage, UI/UX | ✅ |

---

## API Specification

| Requirement | Status | Implementation |
|-------------|--------|----------------|
| **Step 1 – Minimal data for lists** | ✅ | |
| Get All Countries: `.../v3.1/all?fields=name,flags,population,cca2` | ✅ | `CountriesApiService.getAllCountries()` |
| Search by Name: `.../v3.1/name/{name}?fields=name,flags,population,cca2` | ✅ | `CountriesApiService.searchCountriesByName()` |
| cca2 as unique identifier for detail fetch | ✅ | Used in `getCountryDetails(cca2)` |
| **Step 2 – Full data for detail** | ✅ | |
| Get Detailed: `.../v3.1/alpha/{code}?fields=name,flags,population,capital,region,subregion,area,timezones` | ✅ | `CountriesApiService.getCountryDetails(cca2)` |

---

## Data Models

| Model | Field | Status |
|-------|-------|--------|
| **CountrySummary** (lists) | name (common) | ✅ |
| | flag (png or svg) | ✅ `flagPng` / `flagSvg` |
| | population | ✅ |
| | cca2 (unique id) | ✅ |
| **CountryDetails** (detail) | name (common) | ✅ |
| | flags (png or svg) | ✅ |
| | population | ✅ |
| | capital (first element) | ✅ `_capitalFromJson` |
| | region | ✅ |
| | subregion | ✅ |
| | area | ✅ |
| | timezones | ✅ |

---

## User Stories

### User Story 1: View a List of All Countries

| Acceptance criterion | Status |
|----------------------|--------|
| Home shows scrollable list of all countries from API | ✅ |
| Each item: flag, common name, formatted population (e.g. "Population: 47.1M") | ✅ |
| Clear loading state (e.g. shimmer) while fetching | ✅ `CountryListShimmer` |
| API failure → error state with "Retry" option | ✅ |
| Bottom nav with "Home" and "Favorites", Home active | ✅ |

### User Story 2: Search for a Specific Country

| Acceptance criterion | Status |
|----------------------|--------|
| Home has search bar with hint "Search for a country." | ✅ `hintText: 'Search for a country.'` |
| List filters in real-time as user types | ✅ (with debounce) |
| No matches → empty state (e.g. "No countries found.") | ✅ |

### User Story 3: View Detailed Information About a Country

| Acceptance criterion | Status |
|----------------------|--------|
| Tap country → navigate to Country Detail screen | ✅ |
| Separate API call for full details using cca2 | ✅ |
| Loading indicator while fetching details | ✅ |
| Detail shows: large high-quality flag | ✅ |
| "Key Statistics": Area, Population, Region, Sub Region | ✅ |
| "Timezone" section | ✅ |
| App bar: back button + country name as title | ✅ |
| API failure → error state with "Retry" | ✅ |

### User Story 4: Manage a List of Favorite Countries

| Acceptance criterion | Status |
|----------------------|--------|
| Each Home list item has heart icon to toggle favorite | ✅ |
| Heart filled/unfilled reflects status | ✅ |
| Favorites persist locally (survive app restarts) | ✅ SharedPreferences |
| Favorites screen lists all favorited countries | ✅ |
| Favorites item: flag, name, capital city | ✅ |
| Tap filled heart on Favorites → remove from list | ✅ |
| No favorites → empty state message | ✅ |

---

## Technical Requirements

| Requirement | Status | Implementation |
|-------------|--------|----------------|
| State management: clear, scalable; BLoC/Cubit preferred | ✅ | `flutter_bloc`, `CountriesBloc`, `CountryDetailBloc` |
| API client: robust (dio or http); loading/success/error for all calls | ✅ | Dio; Initial/Loading/Loaded/Error in both blocs |
| Local storage: favorites persist; shared_preferences or hive | ✅ | `FavoritesService` + SharedPreferences |
| Data models: immutable (equatable or freezed) | ✅ | Freezed for models; Equatable for BLoC events/states |
| UI/UX: Adhere to Figma | ✅ | Light theme, pill search, bottom nav, detail layout |
| Loading: shimmer/skeleton | ✅ | Shimmer on Home; spinner on Detail |
| Empty and error states with messages and actions | ✅ | Retry buttons; "No countries found."; empty Favorites |
| Code quality: clean, scalable, well-documented | ✅ | Structure, doc comments, unit tests |

---

## Bonus Challenges (Optional)

| Bonus | Status |
|-------|--------|
| Hero animation on country flag (list → detail) | ✅ |
| Dark mode | ✅ System theme |
| Pull-to-refresh on Home | ✅ |
| Search debouncing | ✅ 300 ms |
| Data caching (e.g. dio-http-cache or custom) | ✅ In-memory + SharedPreferences for details |
| Dependency injection (e.g. get_it) | ✅ |
| Code generation (freezed + json_serializable) | ✅ |
| Sorting (name or population) | ✅ Name A–Z, Population high→low |
| Tablet/Web support (responsive UI) | ✅ Rail + 2/3-column grid |

---

## Submission Guidelines

| Requirement | Status |
|-------------|--------|
| Public GitHub repository | ✅ (link in README) |
| Frequent, clear commits | ✅ (your history) |
| README: setup and run locally | ✅ |
| README: environment variables (if any) | ✅ "No environment variables required" in README |
| README: technology/architecture choices | ✅ Design Decisions + Technology sections |
| Final push: all code + README on GitHub | ✅ |
| Build APK | ⚠️ Run `flutter build apk --release` before submit |
| Submit: APK + repo link via Google Form | ✅ (your step) |

---

## Minor Optional Tweaks (Done)

1. **Search hint**: Updated to "Search for a country." (with period) to match spec.
2. **README**: Added "No environment variables required" under Prerequisites.

---

## Summary

- **Core assignment**: All objectives, API spec, data models, user stories, and technical requirements are met.
- **Bonus**: All listed bonus challenges are implemented.
- **Submission**: README and structure are in place; build release APK and submit link + APK via the form.

Good to submit after a final `flutter build apk --release` and upload.

---

## Before submission (Do’s)

- **No secrets:** Keep the project as-is: no `.env` with keys, no hardcoded secrets.
- **After adding a dependency:** Run `flutter pub get` and `flutter run` / `flutter build apk --release`; fix any errors before considering the project done.
- **After build_runner:** Run `dart run build_runner build --delete-conflicting-outputs` only when needed; then run `flutter test` and a quick manual test. Don’t commit half-regenerated code.
