abstract class CalendarService {
  Future<bool> requestPermission();
  Future<bool> hasPermission();
  Future<String?> createCalendar(String name);
  Future<bool> addEvent({
    required String calendarId,
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
  });
}
