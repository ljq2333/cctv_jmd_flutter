import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/errors/exceptions.dart';

void main() {
  group('ApiException', () {
    test('should store message and statusCode', () {
      const exception = ApiException(message: 'Not Found', statusCode: 404);

      expect(exception.message, 'Not Found');
      expect(exception.statusCode, 404);
    });

    test('toString should include message and statusCode', () {
      const exception = ApiException(message: 'Not Found', statusCode: 404);

      expect(exception.toString(), contains('ApiException'));
      expect(exception.toString(), contains('Not Found'));
      expect(exception.toString(), contains('404'));
    });

    test('should support equality', () {
      const exception1 = ApiException(message: 'Error', statusCode: 500);
      const exception2 = ApiException(message: 'Error', statusCode: 500);

      expect(exception1, equals(exception2));
    });
  });

  group('CacheException', () {
    test('should store message', () {
      const exception = CacheException(message: 'Cache miss');

      expect(exception.message, 'Cache miss');
    });

    test('toString should include message', () {
      const exception = CacheException(message: 'Cache miss');

      expect(exception.toString(), contains('CacheException'));
      expect(exception.toString(), contains('Cache miss'));
    });
  });

  group('StorageException', () {
    test('should store message', () {
      const exception = StorageException(message: 'Write failed');

      expect(exception.message, 'Write failed');
    });

    test('toString should include message', () {
      const exception = StorageException(message: 'Write failed');

      expect(exception.toString(), contains('StorageException'));
      expect(exception.toString(), contains('Write failed'));
    });
  });

  group('NetworkException', () {
    test('should store message', () {
      const exception = NetworkException(message: 'No connection');

      expect(exception.message, 'No connection');
    });

    test('toString should include message', () {
      const exception = NetworkException(message: 'No connection');

      expect(exception.toString(), contains('NetworkException'));
      expect(exception.toString(), contains('No connection'));
    });
  });
}
