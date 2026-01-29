import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:countries_app/services/favorites_service.dart';

void main() {
  late FavoritesService service;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    service = FavoritesService();
  });

  group('FavoritesService', () {
    test('getFavoriteCountryCodes returns empty set initially', () async {
      final codes = await service.getFavoriteCountryCodes();
      expect(codes, isEmpty);
    });

    test('addFavorite adds code and getFavoriteCountryCodes returns it', () async {
      final added = await service.addFavorite('ET');
      expect(added, isTrue);

      final codes = await service.getFavoriteCountryCodes();
      expect(codes, contains('ET'));
      expect(codes.length, 1);
    });

    test('removeFavorite removes code', () async {
      await service.addFavorite('ET');
      await service.addFavorite('KE');

      final removed = await service.removeFavorite('ET');
      expect(removed, isTrue);

      final codes = await service.getFavoriteCountryCodes();
      expect(codes, contains('KE'));
      expect(codes, isNot(contains('ET')));
    });

    test('toggleFavorite adds when not present, removes when present', () async {
      final added = await service.toggleFavorite('ET');
      expect(added, isTrue);
      expect(await service.isFavorite('ET'), isTrue);

      final removed = await service.toggleFavorite('ET');
      expect(removed, isTrue);
      expect(await service.isFavorite('ET'), isFalse);
    });

    test('isFavorite returns true only for added codes', () async {
      expect(await service.isFavorite('ET'), isFalse);
      await service.addFavorite('ET');
      expect(await service.isFavorite('ET'), isTrue);
    });
  });
}
