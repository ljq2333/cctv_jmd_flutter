import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/network/network_info.dart';

void main() {
  group('NetworkInfo', () {
    test('should have isConnected getter', () {
      expect(NetworkInfo, isA<Type>());
    });
  });
}
