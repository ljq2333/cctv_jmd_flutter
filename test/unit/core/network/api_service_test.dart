import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/network/api_service.dart';

void main() {
  group('ApiService', () {
    test('ApiService should be an abstract class', () {
      expect(ApiService, isA<Type>());
    });
  });
}
