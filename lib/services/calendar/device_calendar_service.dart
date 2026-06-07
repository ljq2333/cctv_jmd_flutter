import 'calendar_service.dart';

class DeviceCalendarService implements CalendarService {
  @override
  Future<bool> requestPermission() async {
    return true;
  }

  @override
  Future<bool> hasPermission() async {
    return true;
  }

  @override
  Future<String?> createCalendar(String name) async {
    return 'calendar_id';
  }

  @override
  Future<bool> addEvent({
    required String calendarId,
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
  }) async {
    return true;
  }
}
