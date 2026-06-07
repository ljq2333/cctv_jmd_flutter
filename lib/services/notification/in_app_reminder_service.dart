class InAppReminderService {
  final List<ReminderEntry> _activeReminders = [];

  List<ReminderEntry> get activeReminders =>
      List.unmodifiable(_activeReminders);

  void showReminder({
    required int id,
    required String title,
    required String body,
    required String channelId,
  }) {
    final entry = ReminderEntry(
      id: id,
      title: title,
      body: body,
      channelId: channelId,
      shownAt: DateTime.now(),
    );
    _activeReminders.add(entry);
  }

  void dismissReminder(int id) {
    _activeReminders.removeWhere((r) => r.id == id);
  }

  void dismissAll() {
    _activeReminders.clear();
  }
}

class ReminderEntry {
  final int id;
  final String title;
  final String body;
  final String channelId;
  final DateTime shownAt;

  const ReminderEntry({
    required this.id,
    required this.title,
    required this.body,
    required this.channelId,
    required this.shownAt,
  });
}
