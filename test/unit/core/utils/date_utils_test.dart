import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/utils/date_utils.dart';

void main() {
  group('AppDateUtils', () {
    group('formatToApiDate', () {
      test('should format date to yyyyMMdd', () {
        final date = DateTime(2026, 6, 7);
        expect(AppDateUtils.formatToApiDate(date), '20260607');
      });

      test('should pad single digit month and day', () {
        final date = DateTime(2026, 1, 5);
        expect(AppDateUtils.formatToApiDate(date), '20260105');
      });
    });

    group('formatToDisplayDate', () {
      test('should format date to yyyy年MM月dd日', () {
        final date = DateTime(2026, 6, 7);
        expect(AppDateUtils.formatToDisplayDate(date), '2026年06月07日');
      });
    });

    group('formatToTime', () {
      test('should format time to HH:mm', () {
        final date = DateTime(2026, 6, 7, 14, 30);
        expect(AppDateUtils.formatToTime(date), '14:30');
      });

      test('should pad single digit hour and minute', () {
        final date = DateTime(2026, 6, 7, 9, 5);
        expect(AppDateUtils.formatToTime(date), '09:05');
      });
    });

    group('isToday', () {
      test('should return true for today', () {
        expect(AppDateUtils.isToday(DateTime.now()), isTrue);
      });

      test('should return false for yesterday', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        expect(AppDateUtils.isToday(yesterday), isFalse);
      });
    });

    group('isCurrentProgram', () {
      test('should return true for current time range', () {
        final now = DateTime.now();
        final start = now.subtract(const Duration(hours: 1));
        final end = now.add(const Duration(hours: 1));

        expect(AppDateUtils.isCurrentProgram(start, end), isTrue);
      });

      test('should return false for past program', () {
        final now = DateTime.now();
        final start = now.subtract(const Duration(hours: 2));
        final end = now.subtract(const Duration(hours: 1));

        expect(AppDateUtils.isCurrentProgram(start, end), isFalse);
      });
    });

    group('getDateRange', () {
      test('should return correct date range', () {
        final range = AppDateUtils.getDateRange();

        expect(range.length, 7);
      });
    });
  });
}
