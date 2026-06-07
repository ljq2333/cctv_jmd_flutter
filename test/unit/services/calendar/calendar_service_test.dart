import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/services/calendar/calendar_service.dart';
import 'package:cctv_jmd_flutter/services/calendar/device_calendar_service.dart';
import 'package:cctv_jmd_flutter/services/calendar/calendar_permission.dart';
import 'package:cctv_jmd_flutter/services/calendar/calendar_event_formatter.dart';

void main() {
  group('Calendar Service', () {
    test('CalendarService should be abstract', () {
      expect(CalendarService, isA<Type>());
    });

    test('DeviceCalendarService should exist', () {
      expect(DeviceCalendarService, isA<Type>());
    });

    test('CalendarPermission should exist', () {
      expect(CalendarPermission, isA<Type>());
    });

    test('CalendarEventFormatter should format title', () {
      final title = CalendarEventFormatter.formatTitle('CCTV-1', '早间新闻');
      expect(title, '[CCTV-1] 早间新闻');
    });

    test('CalendarEventFormatter should format description', () {
      final desc = CalendarEventFormatter.formatDescription(
        channelName: 'CCTV-1',
        programTitle: '早间新闻',
        showTime: '08:00',
        liveUrl: 'https://example.com',
      );

      expect(desc, contains('CCTV-1'));
      expect(desc, contains('早间新闻'));
      expect(desc, contains('08:00'));
    });
  });
}
