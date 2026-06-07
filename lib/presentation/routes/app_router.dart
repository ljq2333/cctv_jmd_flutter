import 'package:flutter/material.dart';
import 'package:cctv_jmd_flutter/presentation/pages/home_page.dart';
import 'package:cctv_jmd_flutter/presentation/pages/search_page.dart';
import 'package:cctv_jmd_flutter/presentation/pages/favorites_page.dart';
import 'package:cctv_jmd_flutter/presentation/pages/settings_page.dart';

class AppRouter {
  static const String home = '/';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesPage());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('未找到页面: ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}
