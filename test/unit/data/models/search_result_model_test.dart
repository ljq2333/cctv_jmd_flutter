import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/data/models/search_result_model.dart';
import 'package:cctv_jmd_flutter/data/models/program_model.dart';

void main() {
  group('SearchResult', () {
    test('should create SearchResult', () {
      const program = Program(
        title: '早间新闻',
        startTime: 100,
        endTime: 200,
        showTime: '08:00',
        length: 100,
      );

      const result = SearchResult(
        channelId: 'cctv1',
        channelName: 'CCTV-1',
        program: program,
      );

      expect(result.channelId, 'cctv1');
      expect(result.program.title, '早间新闻');
    });
  });
}
