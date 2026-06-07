import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/data/datasources/cache_data_source.dart';
import 'package:cctv_jmd_flutter/data/datasources/local_data_source_impl.dart';
import 'package:cctv_jmd_flutter/data/datasources/remote_data_source_impl.dart';
import 'package:cctv_jmd_flutter/data/repositories/epg_repository_impl.dart';
import 'package:cctv_jmd_flutter/data/repositories/favorites_repository_impl.dart';
import 'package:cctv_jmd_flutter/data/repositories/reminders_repository_impl.dart';
import 'package:cctv_jmd_flutter/data/repositories/user_settings_repository_impl.dart';
import 'package:cctv_jmd_flutter/domain/repositories/epg_repository.dart';
import 'package:cctv_jmd_flutter/domain/repositories/favorites_repository.dart';
import 'package:cctv_jmd_flutter/domain/repositories/reminders_repository.dart';
import 'package:cctv_jmd_flutter/domain/repositories/user_settings_repository.dart';
import 'core_providers.dart';

final epgRepositoryProvider = Provider<EpgRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final remoteDataSource = RemoteDataSourceImpl(apiService);
  final cacheDataSource = CacheDataSource();
  return EpgRepositoryImpl(remoteDataSource, cacheDataSource);
});

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final localDataSource = LocalDataSourceImpl(storageService);
  return FavoritesRepositoryImpl(localDataSource);
});

final remindersRepositoryProvider = Provider<RemindersRepository>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final localDataSource = LocalDataSourceImpl(storageService);
  return RemindersRepositoryImpl(localDataSource);
});

final userSettingsRepositoryProvider = Provider<UserSettingsRepository>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final localDataSource = LocalDataSourceImpl(storageService);
  return UserSettingsRepositoryImpl(localDataSource);
});
