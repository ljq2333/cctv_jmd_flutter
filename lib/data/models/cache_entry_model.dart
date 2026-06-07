class CacheEntry {
  final String key;
  final Map<String, dynamic> data;
  final int timestamp;
  final int expirationDays;

  const CacheEntry({
    required this.key,
    required this.data,
    required this.timestamp,
    this.expirationDays = 7,
  });

  bool get isExpired {
    final expirationTime =
        timestamp + (expirationDays * 24 * 60 * 60);
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return now > expirationTime;
  }

  factory CacheEntry.fromJson(Map<String, dynamic> json) {
    return CacheEntry(
      key: json['key'] as String? ?? '',
      data: json['data'] as Map<String, dynamic>? ?? {},
      timestamp: json['timestamp'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'data': data,
      'timestamp': timestamp,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheEntry &&
          runtimeType == other.runtimeType &&
          key == other.key;

  @override
  int get hashCode => key.hashCode;
}
