import 'notification_service.dart';

class NotificationPermission {
  final NotificationService _service;

  NotificationPermission(this._service);

  Future<bool> checkAndRequestPermission() async {
    final hasPermission = await _service.hasPermission();
    if (hasPermission) return true;

    return _service.requestPermission();
  }

  Future<PermissionStatus> getStatus() async {
    final hasPermission = await _service.hasPermission();
    return hasPermission
        ? PermissionStatus.granted
        : PermissionStatus.denied;
  }
}

enum PermissionStatus { granted, denied }
