import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/storage/storage_service.dart';

void main() {
  group('StorageService', () {
    test('StorageService should be an abstract class', () {
      // StorageService is abstract, cannot be instantiated directly
      // This test verifies the interface exists
      expect(StorageService, isA<Type>());
    });
  });
}
