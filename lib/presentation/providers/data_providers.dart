import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/data/models/epg_data_model.dart';
import 'package:cctv_jmd_flutter/data/models/favorite_model.dart';
import 'package:cctv_jmd_flutter/data/models/reminder_model.dart';
import 'package:cctv_jmd_flutter/data/models/search_result_model.dart';
import 'package:cctv_jmd_flutter/data/models/user_settings_model.dart';
import 'state_providers.dart';
import 'usecase_providers.dart';

final epgDataProvider = FutureProvider.family<EpgData, String>((ref, channelId) async {
  final date = ref.watch(selectedDateProvider);
  final useCase = ref.watch(getEpgUseCaseProvider);
  final result = await useCase.execute(channelId: channelId, date: date);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (data) => data,
  );
});

final favoritesProvider = FutureProvider<List<Favorite>>((ref) async {
  final useCase = ref.watch(manageFavoritesUseCaseProvider);
  final result = await useCase.getFavorites();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (data) => data,
  );
});

final remindersProvider = FutureProvider<List<Reminder>>((ref) async {
  final useCase = ref.watch(manageRemindersUseCaseProvider);
  final result = await useCase.getReminders();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (data) => data,
  );
});

final userSettingsProvider = FutureProvider<UserSettings>((ref) async {
  final useCase = ref.watch(manageSettingsUseCaseProvider);
  final result = await useCase.getSettings();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (data) => data,
  );
});

final searchResultsProvider = FutureProvider<List<SearchResult>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];

  final channelId = ref.watch(currentChannelProvider);
  final scope = ref.watch(searchScopeProvider);
  final useCase = ref.watch(searchProgramsUseCaseProvider);
  final date = ref.watch(selectedDateProvider);

  final result = await useCase.execute(
    query: query,
    channelId: scope == SearchScope.currentChannel ? channelId : null,
    date: date,
  );

  return result.fold(
    (failure) => throw Exception(failure.message),
    (data) => data,
  );
});
