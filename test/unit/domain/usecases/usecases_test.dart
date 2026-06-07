import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/domain/usecases/get_epg_usecase.dart';
import 'package:cctv_jmd_flutter/domain/usecases/search_programs_usecase.dart';
import 'package:cctv_jmd_flutter/domain/usecases/manage_favorites_usecase.dart';
import 'package:cctv_jmd_flutter/domain/usecases/manage_reminders_usecase.dart';
import 'package:cctv_jmd_flutter/domain/usecases/manage_settings_usecase.dart';

void main() {
  group('Use Cases', () {
    test('GetEpgUseCase should exist', () {
      expect(GetEpgUseCase, isA<Type>());
    });

    test('SearchProgramsUseCase should exist', () {
      expect(SearchProgramsUseCase, isA<Type>());
    });

    test('ManageFavoritesUseCase should exist', () {
      expect(ManageFavoritesUseCase, isA<Type>());
    });

    test('ManageRemindersUseCase should exist', () {
      expect(ManageRemindersUseCase, isA<Type>());
    });

    test('ManageSettingsUseCase should exist', () {
      expect(ManageSettingsUseCase, isA<Type>());
    });
  });
}
