import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/domain/repositories/epg_repository.dart';
import 'package:cctv_jmd_flutter/domain/repositories/favorites_repository.dart';
import 'package:cctv_jmd_flutter/domain/repositories/reminders_repository.dart';
import 'package:cctv_jmd_flutter/domain/repositories/user_settings_repository.dart';

void main() {
  group('Repository Interfaces', () {
    test('EpgRepository should be abstract', () {
      expect(EpgRepository, isA<Type>());
    });

    test('FavoritesRepository should be abstract', () {
      expect(FavoritesRepository, isA<Type>());
    });

    test('RemindersRepository should be abstract', () {
      expect(RemindersRepository, isA<Type>());
    });

    test('UserSettingsRepository should be abstract', () {
      expect(UserSettingsRepository, isA<Type>());
    });
  });
}
