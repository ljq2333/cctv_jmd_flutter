import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/errors/exceptions.dart';
import 'package:cctv_jmd_flutter/core/errors/failures.dart';
import 'package:cctv_jmd_flutter/core/errors/error_handler.dart';

void main() {
  group('ErrorHandler', () {
    group('handleException', () {
      test('should convert ApiException to ApiFailure', () {
        const exception = ApiException(message: 'Not Found', statusCode: 404);

        final failure = ErrorHandler.handleException(exception);

        expect(failure, isA<ApiFailure>());
        expect(failure.message, contains('Not Found'));
      });

      test('should convert CacheException to CacheFailure', () {
        const exception = CacheException(message: 'Cache miss');

        final failure = ErrorHandler.handleException(exception);

        expect(failure, isA<CacheFailure>());
        expect(failure.message, contains('Cache'));
      });

      test('should convert StorageException to StorageFailure', () {
        const exception = StorageException(message: 'Write failed');

        final failure = ErrorHandler.handleException(exception);

        expect(failure, isA<StorageFailure>());
        expect(failure.message, contains('存储'));
      });

      test('should convert NetworkException to NetworkFailure', () {
        const exception = NetworkException(message: 'No connection');

        final failure = ErrorHandler.handleException(exception);

        expect(failure, isA<NetworkFailure>());
        expect(failure.message, contains('网络'));
      });
    });

    group('getErrorMessage', () {
      test('should return user-friendly message for ApiFailure', () {
        const failure = ApiFailure(message: 'Server error');

        final message = ErrorHandler.getErrorMessage(failure);

        expect(message, isNotEmpty);
      });

      test('should return user-friendly message for NetworkFailure', () {
        const failure = NetworkFailure(message: 'No internet');

        final message = ErrorHandler.getErrorMessage(failure);

        expect(message, contains('网络'));
      });
    });
  });
}
