import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/utils/validator_utils.dart';

void main() {
  group('ValidatorUtils', () {
    group('isValidChannelId', () {
      test('should return true for valid channel id', () {
        expect(ValidatorUtils.isValidChannelId('cctv1'), isTrue);
      });

      test('should return false for empty string', () {
        expect(ValidatorUtils.isValidChannelId(''), isFalse);
      });

      test('should return false for invalid channel id', () {
        expect(ValidatorUtils.isValidChannelId('invalid'), isFalse);
      });
    });

    group('isValidDate', () {
      test('should return true for valid date', () {
        expect(ValidatorUtils.isValidDate('20260607'), isTrue);
      });

      test('should return false for invalid format', () {
        expect(ValidatorUtils.isValidDate('2026-06-07'), isFalse);
      });

      test('should return false for invalid date', () {
        expect(ValidatorUtils.isValidDate('20260230'), isFalse);
      });
    });

    group('isValidSearchQuery', () {
      test('should return true for valid query', () {
        expect(ValidatorUtils.isValidSearchQuery('新闻'), isTrue);
      });

      test('should return false for empty query', () {
        expect(ValidatorUtils.isValidSearchQuery(''), isFalse);
      });

      test('should return false for whitespace only', () {
        expect(ValidatorUtils.isValidSearchQuery('   '), isFalse);
      });
    });
  });
}
