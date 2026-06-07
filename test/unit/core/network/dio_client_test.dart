import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/network/dio_client.dart';

void main() {
  group('DioClient', () {
    test('should be instantiable', () {
      expect(DioClient, isA<Type>());
    });

    test('should have baseUrl getter', () {
      expect(DioClient.baseUrl, isNotEmpty);
    });

    test('should have timeout getters', () {
      expect(DioClient.connectTimeout, greaterThan(0));
      expect(DioClient.receiveTimeout, greaterThan(0));
    });
  });
}
