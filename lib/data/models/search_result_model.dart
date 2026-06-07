import 'program_model.dart';

class SearchResult {
  final String channelId;
  final String channelName;
  final Program program;

  const SearchResult({
    required this.channelId,
    required this.channelName,
    required this.program,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchResult &&
          runtimeType == other.runtimeType &&
          channelId == other.channelId &&
          program == other.program;

  @override
  int get hashCode => Object.hash(channelId, program);
}
