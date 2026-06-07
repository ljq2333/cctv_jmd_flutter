import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/errors/failures.dart';

void main() {
  group('Failure', () {
    test('ApiFailure should store message', () {
      const failure = ApiFailure(message: 'Server error');

      expect(failure.message, 'Server error');
    });

    test('ApiFailure toString should include message', () {
      const failure = ApiFailure(message: 'Server error');

      expect(failure.toString(), contains('ApiFailure'));
      expect(failure.toString(), contains('Server error'));
    });

    test('CacheFailure should store message', () {
      const failure = CacheFailure(message: 'Cache expired');

      expect(failure.message, 'Cache expired');
    });

    test('CacheFailure toString should include message', () {
      const failure = CacheFailure(message: 'Cache expired');

      expect(failure.toString(), contains('CacheFailure'));
      expect(failure.toString(), contains('Cache expired'));
    });

    test('StorageFailure should store message', () {
      const failure = StorageFailure(message: 'Storage full');

      expect(failure.message, 'Storage full');
    });

    test('StorageFailure toString should include message', () {
      const failure = StorageFailure(message: 'Storage full');

      expect(failure.toString(), contains('StorageFailure'));
      expect(failure.toString(), contains('Storage full'));
    });

    test('NetworkFailure should store message', () {
      const failure = NetworkFailure(message: 'No internet');

      expect(failure.message, 'No internet');
    });

    test('NetworkFailure toString should include message', () {
      const failure = NetworkFailure(message: 'No internet');

      expect(failure.toString(), contains('NetworkFailure'));
      expect(failure.toString(), contains('No internet'));
    });

    test('all failures should support equality', () {
      const apiFailure1 = ApiFailure(message: 'Error');
      const apiFailure2 = ApiFailure(message: 'Error');

      expect(apiFailure1, equals(apiFailure2));
    });
  });
}
