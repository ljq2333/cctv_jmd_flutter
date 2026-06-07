import 'program_model.dart';

class EpgData {
  final String channelId;
  final String channelName;
  final String date;
  final List<Program> programs;
  final Program? currentProgram;
  final String liveUrl;

  const EpgData({
    required this.channelId,
    required this.channelName,
    required this.date,
    required this.programs,
    this.currentProgram,
    required this.liveUrl,
  });

  factory EpgData.fromJson(Map<String, dynamic> json, String channelId) {
    final channelData = json['data']?[channelId] as Map<String, dynamic>?;
    if (channelData == null) {
      return EpgData(
        channelId: channelId,
        channelName: '',
        date: '',
        programs: [],
        liveUrl: '',
      );
    }

    final programList = (channelData['list'] as List<dynamic>?)
            ?.map((e) => Program.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    Program? currentProgram;
    for (final program in programList) {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      if (now >= program.startTime && now <= program.endTime) {
        currentProgram = program;
        break;
      }
    }

    return EpgData(
      channelId: channelId,
      channelName: channelData['channelName'] as String? ?? '',
      date: '',
      programs: programList,
      currentProgram: currentProgram,
      liveUrl: channelData['lvUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'channelId': channelId,
      'channelName': channelName,
      'date': date,
      'programs': programs.map((e) => e.toJson()).toList(),
      'liveUrl': liveUrl,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpgData &&
          runtimeType == other.runtimeType &&
          channelId == other.channelId &&
          date == other.date;

  @override
  int get hashCode => Object.hash(channelId, date);
}
