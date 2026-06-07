import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/presentation/pages/home_page.dart';
import 'package:cctv_jmd_flutter/presentation/pages/search_page.dart';
import 'package:cctv_jmd_flutter/presentation/pages/favorites_page.dart';
import 'package:cctv_jmd_flutter/presentation/pages/settings_page.dart';
import 'package:cctv_jmd_flutter/presentation/routes/app_router.dart';

void main() {
  group('Pages', () {
    test('HomePage should exist', () {
      expect(HomePage, isA<Type>());
    });

    test('SearchPage should exist', () {
      expect(SearchPage, isA<Type>());
    });

    test('FavoritesPage should exist', () {
      expect(FavoritesPage, isA<Type>());
    });

    test('SettingsPage should exist', () {
      expect(SettingsPage, isA<Type>());
    });
  });

  group('AppRouter', () {
    test('should have route paths', () {
      expect(AppRouter.home, '/');
      expect(AppRouter.search, '/search');
      expect(AppRouter.favorites, '/favorites');
      expect(AppRouter.settings, '/settings');
    });

    test('should generate route for home', () {
      final route = AppRouter.generateRoute(
        RouteSettings(name: '/'),
      );
      expect(route, isNotNull);
    });

    test('should generate route for unknown path', () {
      final route = AppRouter.generateRoute(
        RouteSettings(name: '/unknown'),
      );
      expect(route, isNotNull);
    });
  });
}
