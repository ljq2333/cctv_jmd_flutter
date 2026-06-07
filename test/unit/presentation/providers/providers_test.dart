import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/presentation/providers/core_providers.dart';
import 'package:cctv_jmd_flutter/presentation/providers/repository_providers.dart';
import 'package:cctv_jmd_flutter/presentation/providers/usecase_providers.dart';
import 'package:cctv_jmd_flutter/presentation/providers/state_providers.dart';
import 'package:cctv_jmd_flutter/presentation/providers/data_providers.dart';

void main() {
  group('Providers', () {
    test('Core providers should exist', () {
      expect(dioClientProvider, isNotNull);
      expect(apiServiceProvider, isNotNull);
      expect(storageServiceProvider, isNotNull);
      expect(networkInfoProvider, isNotNull);
    });

    test('Repository providers should exist', () {
      expect(epgRepositoryProvider, isNotNull);
      expect(favoritesRepositoryProvider, isNotNull);
      expect(remindersRepositoryProvider, isNotNull);
      expect(userSettingsRepositoryProvider, isNotNull);
    });

    test('Use case providers should exist', () {
      expect(getEpgUseCaseProvider, isNotNull);
      expect(searchProgramsUseCaseProvider, isNotNull);
      expect(manageFavoritesUseCaseProvider, isNotNull);
      expect(manageRemindersUseCaseProvider, isNotNull);
      expect(manageSettingsUseCaseProvider, isNotNull);
    });

    test('State providers should exist', () {
      expect(currentChannelProvider, isNotNull);
      expect(selectedDateProvider, isNotNull);
      expect(searchQueryProvider, isNotNull);
      expect(searchScopeProvider, isNotNull);
    });

    test('Data providers should exist', () {
      expect(epgDataProvider, isNotNull);
      expect(favoritesProvider, isNotNull);
      expect(searchResultsProvider, isNotNull);
    });

    test('SearchScope enum should have values', () {
      expect(SearchScope.values.length, 2);
      expect(SearchScope.currentChannel, isNotNull);
      expect(SearchScope.allChannels, isNotNull);
    });
  });
}
