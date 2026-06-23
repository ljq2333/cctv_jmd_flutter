import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/core/network/dio_client.dart';
import 'package:cctv_jmd_flutter/core/network/cntv_api_service.dart';
import 'package:cctv_jmd_flutter/core/network/network_info.dart';
import 'package:cctv_jmd_flutter/core/storage/hive_storage_service.dart';
import 'package:cctv_jmd_flutter/core/storage/storage_service.dart';
import 'package:cctv_jmd_flutter/services/calendar/calendar_service.dart';
import 'package:cctv_jmd_flutter/services/calendar/device_calendar_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final apiServiceProvider = Provider<CntvApiService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CntvApiService(dioClient);
});

final storageServiceProvider = Provider<StorageService>((ref) {
  return HiveStorageService();
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfo(Connectivity());
});

final calendarServiceProvider = Provider<CalendarService>((ref) {
  return DeviceCalendarService();
});
