class Favorite {
  final String id;
  final String channelId;
  final String channelName;
  final String title;
  final int startTime;
  final String date;

  const Favorite({
    required this.id,
    required this.channelId,
    required this.channelName,
    required this.title,
    required this.startTime,
    required this.date,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'] as String? ?? '',
      channelId: json['channelId'] as String? ?? '',
      channelName: json['channelName'] as String? ?? '',
      title: json['title'] as String? ?? '',
      startTime: json['startTime'] as int? ?? 0,
      date: json['date'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'channelId': channelId,
      'channelName': channelName,
      'title': title,
      'startTime': startTime,
      'date': date,
    };
  }

  Favorite copyWith({
    String? id,
    String? channelId,
    String? channelName,
    String? title,
    int? startTime,
    String? date,
  }) {
    return Favorite(
      id: id ?? this.id,
      channelId: channelId ?? this.channelId,
      channelName: channelName ?? this.channelName,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      date: date ?? this.date,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Favorite &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
