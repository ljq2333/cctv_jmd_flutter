enum AppThemeMode { system, light, dark }

enum ReminderMethod { notification, inApp, calendar }

class UserSettings {
  final AppThemeMode themeMode;
  final String lastChannelId;
  final bool reminderEnabled;
  final List<ReminderMethod> reminderMethods;
  final int reminderMinutesBefore;

  const UserSettings({
    this.themeMode = AppThemeMode.system,
    this.lastChannelId = 'cctv1',
    this.reminderEnabled = true,
    this.reminderMethods = const [
      ReminderMethod.notification,
      ReminderMethod.inApp,
    ],
    this.reminderMinutesBefore = 5,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      themeMode: AppThemeMode.values.firstWhere(
        (e) => e.name == json['theme'],
        orElse: () => AppThemeMode.system,
      ),
      lastChannelId: json['lastChannel'] as String? ?? 'cctv1',
      reminderEnabled: json['reminderEnabled'] as bool? ?? true,
      reminderMethods: (json['reminderMethods'] as List<dynamic>?)
              ?.map((e) => ReminderMethod.values.firstWhere(
                    (m) => m.name == e,
                    orElse: () => ReminderMethod.inApp,
                  ))
              .toList() ??
          [ReminderMethod.notification, ReminderMethod.inApp],
      reminderMinutesBefore: json['reminderMinutesBefore'] as int? ?? 5,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'theme': themeMode.name,
      'lastChannel': lastChannelId,
      'reminderEnabled': reminderEnabled,
      'reminderMethods': reminderMethods.map((e) => e.name).toList(),
      'reminderMinutesBefore': reminderMinutesBefore,
    };
  }

  UserSettings copyWith({
    AppThemeMode? themeMode,
    String? lastChannelId,
    bool? reminderEnabled,
    List<ReminderMethod>? reminderMethods,
    int? reminderMinutesBefore,
  }) {
    return UserSettings(
      themeMode: themeMode ?? this.themeMode,
      lastChannelId: lastChannelId ?? this.lastChannelId,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderMethods: reminderMethods ?? this.reminderMethods,
      reminderMinutesBefore:
          reminderMinutesBefore ?? this.reminderMinutesBefore,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettings &&
          runtimeType == other.runtimeType &&
          themeMode == other.themeMode &&
          lastChannelId == other.lastChannelId;

  @override
  int get hashCode => Object.hash(themeMode, lastChannelId);
}
