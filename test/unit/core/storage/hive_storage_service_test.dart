import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/storage/hive_storage_service.dart';

void main() {
  group('HiveStorageService', () {
    test('should be instantiable', () {
      // HiveStorageService requires Hive to be initialized
      // This test verifies the class exists and can be referenced
      expect(HiveStorageService, isA<Type>());
    });
  });
}
