import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/data/models/epg_data_model.dart';

void main() {
  group('EpgData', () {
    test('should create from JSON', () {
      final json = {
        'data': {
          'cctv1': {
            'channelName': 'CCTV-1 综合',
            'lvUrl': 'https://tv.cctv.com/live/cctv1',
            'list': [
              {
                'title': '早间新闻',
                'startTime': 1780763470,
                'endTime': 1780766170,
                'showTime': '00:31',
                'length': 2700,
              }
            ],
          },
        },
      };

      final epg = EpgData.fromJson(json, 'cctv1');

      expect(epg.channelId, 'cctv1');
      expect(epg.channelName, 'CCTV-1 综合');
      expect(epg.programs.length, 1);
      expect(epg.programs.first.title, '早间新闻');
    });

    test('should handle missing channel data', () {
      final json = {'data': {}};

      final epg = EpgData.fromJson(json, 'cctv999');

      expect(epg.channelId, 'cctv999');
      expect(epg.programs, isEmpty);
    });

    test('should convert to JSON', () {
      const epg = EpgData(
        channelId: 'cctv1',
        channelName: 'CCTV-1',
        date: '20260607',
        programs: [],
        liveUrl: 'https://example.com',
      );

      final json = epg.toJson();

      expect(json['channelId'], 'cctv1');
      expect(json['channelName'], 'CCTV-1');
    });
  });
}
