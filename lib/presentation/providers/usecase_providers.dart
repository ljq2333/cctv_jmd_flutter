import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/domain/usecases/get_epg_usecase.dart';
import 'package:cctv_jmd_flutter/domain/usecases/search_programs_usecase.dart';
import 'package:cctv_jmd_flutter/domain/usecases/manage_favorites_usecase.dart';
import 'package:cctv_jmd_flutter/domain/usecases/manage_reminders_usecase.dart';
import 'package:cctv_jmd_flutter/domain/usecases/manage_settings_usecase.dart';
import 'repository_providers.dart';

final getEpgUseCaseProvider = Provider<GetEpgUseCase>((ref) {
  final repository = ref.watch(epgRepositoryProvider);
  return GetEpgUseCase(repository);
});

final searchProgramsUseCaseProvider = Provider<SearchProgramsUseCase>((ref) {
  final repository = ref.watch(epgRepositoryProvider);
  return SearchProgramsUseCase(repository);
});

final manageFavoritesUseCaseProvider = Provider<ManageFavoritesUseCase>((ref) {
  final repository = ref.watch(favoritesRepositoryProvider);
  return ManageFavoritesUseCase(repository);
});

final manageRemindersUseCaseProvider = Provider<ManageRemindersUseCase>((ref) {
  final repository = ref.watch(remindersRepositoryProvider);
  return ManageRemindersUseCase(repository);
});

final manageSettingsUseCaseProvider = Provider<ManageSettingsUseCase>((ref) {
  final repository = ref.watch(userSettingsRepositoryProvider);
  return ManageSettingsUseCase(repository);
});
