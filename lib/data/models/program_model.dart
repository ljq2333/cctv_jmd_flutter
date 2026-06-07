class Program {
  final String title;
  final int startTime;
  final int endTime;
  final String showTime;
  final int length;
  final String? columnUrl;
  final String? videoUrl;

  const Program({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.showTime,
    required this.length,
    this.columnUrl,
    this.videoUrl,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      title: json['title'] as String? ?? '',
      startTime: json['startTime'] as int? ?? 0,
      endTime: json['endTime'] as int? ?? 0,
      showTime: json['showTime'] as String? ?? '',
      length: json['length'] as int? ?? 0,
      columnUrl: json['column_url'] as String?,
      videoUrl: json['columnBackvideourl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'showTime': showTime,
      'length': length,
      'column_url': columnUrl,
      'columnBackvideourl': videoUrl,
    };
  }

  Program copyWith({
    String? title,
    int? startTime,
    int? endTime,
    String? showTime,
    int? length,
    String? columnUrl,
    String? videoUrl,
  }) {
    return Program(
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      showTime: showTime ?? this.showTime,
      length: length ?? this.length,
      columnUrl: columnUrl ?? this.columnUrl,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Program &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          startTime == other.startTime &&
          endTime == other.endTime;

  @override
  int get hashCode => Object.hash(title, startTime, endTime);
}
