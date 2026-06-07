class Reminder {
  final String id;
  final String channelId;
  final String title;
  final int startTime;
  final int reminderTime;
  final bool enabled;

  const Reminder({
    required this.id,
    required this.channelId,
    required this.title,
    required this.startTime,
    required this.reminderTime,
    this.enabled = true,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] as String? ?? '',
      channelId: json['channelId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      startTime: json['startTime'] as int? ?? 0,
      reminderTime: json['reminderTime'] as int? ?? 0,
      enabled: json['enabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'channelId': channelId,
      'title': title,
      'startTime': startTime,
      'reminderTime': reminderTime,
      'enabled': enabled,
    };
  }

  Reminder copyWith({
    String? id,
    String? channelId,
    String? title,
    int? startTime,
    int? reminderTime,
    bool? enabled,
  }) {
    return Reminder(
      id: id ?? this.id,
      channelId: channelId ?? this.channelId,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      reminderTime: reminderTime ?? this.reminderTime,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Reminder &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
