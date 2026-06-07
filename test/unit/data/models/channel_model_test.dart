import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/data/models/channel_model.dart';

void main() {
  group('ChannelModel', () {
    test('should create from JSON', () {
      final json = {
        'channelId': 'cctv1',
        'channelName': 'CCTV-1 综合',
        'lvUrl': 'https://tv.cctv.com/live/cctv1',
        'isLive': '直播中',
      };

      final channel = ChannelModel.fromJson(json);

      expect(channel.id, 'cctv1');
      expect(channel.name, 'CCTV-1 综合');
      expect(channel.liveUrl, 'https://tv.cctv.com/live/cctv1');
    });

    test('should convert to JSON', () {
      const channel = ChannelModel(
        id: 'cctv1',
        name: 'CCTV-1',
        liveUrl: 'https://example.com',
      );

      final json = channel.toJson();

      expect(json['channelId'], 'cctv1');
      expect(json['channelName'], 'CCTV-1');
    });
  });
}
