import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/data/models/program_model.dart';

void main() {
  group('Program', () {
    test('should create Program from JSON', () {
      final json = {
        'title': '早间新闻',
        'startTime': 1780763470,
        'endTime': 1780766170,
        'showTime': '00:31',
        'length': 2700,
        'column_url': 'https://example.com',
        'columnBackvideourl': 'https://video.example.com',
      };

      final program = Program.fromJson(json);

      expect(program.title, '早间新闻');
      expect(program.startTime, 1780763470);
      expect(program.endTime, 1780766170);
      expect(program.showTime, '00:31');
      expect(program.length, 2700);
    });

    test('should convert to JSON', () {
      const program = Program(
        title: 'Test',
        startTime: 100,
        endTime: 200,
        showTime: '01:00',
        length: 100,
      );

      final json = program.toJson();

      expect(json['title'], 'Test');
      expect(json['startTime'], 100);
    });

    test('should support copyWith', () {
      const program = Program(
        title: 'Original',
        startTime: 100,
        endTime: 200,
        showTime: '01:00',
        length: 100,
      );

      final copied = program.copyWith(title: 'Updated');

      expect(copied.title, 'Updated');
      expect(copied.startTime, 100);
    });

    test('should handle null fields in JSON', () {
      final json = <String, dynamic>{};

      final program = Program.fromJson(json);

      expect(program.title, '');
      expect(program.startTime, 0);
    });
  });
}
