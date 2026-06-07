import 'calendar_service.dart';

class CalendarPermission {
  final CalendarService _service;

  CalendarPermission(this._service);

  Future<bool> checkAndRequestPermission() async {
    final hasPermission = await _service.hasPermission();
    if (hasPermission) return true;
    return _service.requestPermission();
  }
}
