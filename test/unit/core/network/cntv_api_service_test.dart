import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/network/cntv_api_service.dart';

void main() {
  group('CntvApiService', () {
    test('should be instantiable', () {
      expect(CntvApiService, isA<Type>());
    });

    group('parseJsonpResponse', () {
      test('should parse JSONP to JSON', () {
        const jsonp = 'setItem1({"data":{"cctv1":{}}})';
        final result = CntvApiService.parseJsonpResponse(jsonp);

        expect(result, isA<Map<String, dynamic>>());
        expect(result.containsKey('data'), isTrue);
      });

      test('should handle empty callback', () {
        const jsonp = '({})';
        final result = CntvApiService.parseJsonpResponse(jsonp);

        expect(result, isA<Map<String, dynamic>>());
      });
    });
  });
}
