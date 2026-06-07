import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/constants/channel_constants.dart';

void main() {
  group('Channel', () {
    test('should create Channel with required fields', () {
      const channel = Channel(
        id: 'cctv1',
        name: 'CCTV-1 综合',
        liveUrl: 'https://tv.cctv.com/live/cctv1',
      );

      expect(channel.id, 'cctv1');
      expect(channel.name, 'CCTV-1 综合');
      expect(channel.liveUrl, 'https://tv.cctv.com/live/cctv1');
    });

    test('should support equality comparison', () {
      const channel1 = Channel(
        id: 'cctv1',
        name: 'CCTV-1 综合',
        liveUrl: 'https://tv.cctv.com/live/cctv1',
      );
      const channel2 = Channel(
        id: 'cctv1',
        name: 'CCTV-1 综合',
        liveUrl: 'https://tv.cctv.com/live/cctv1',
      );

      expect(channel1, equals(channel2));
    });
  });

  group('ChannelConstants', () {
    test('channels list should not be empty', () {
      expect(ChannelConstants.channels, isNotEmpty);
    });

    test('channels should contain CCTV1 to CCTV17', () {
      final ids = ChannelConstants.channels.map((c) => c.id).toList();

      expect(ids, contains('cctv1'));
      expect(ids, contains('cctv2'));
      expect(ids, contains('cctv3'));
      expect(ids, contains('cctv4'));
      expect(ids, contains('cctv5'));
      expect(ids, contains('cctv6'));
      expect(ids, contains('cctv7'));
      expect(ids, contains('cctv8'));
      expect(ids, contains('cctv10'));
      expect(ids, contains('cctv11'));
      expect(ids, contains('cctv12'));
      expect(ids, contains('cctv13'));
      expect(ids, contains('cctv15'));
      expect(ids, contains('cctv16'));
      expect(ids, contains('cctv17'));
    });

    test('channels should contain special channels', () {
      final ids = ChannelConstants.channels.map((c) => c.id).toList();

      expect(ids, contains('cctveurope'));
      expect(ids, contains('cctvamerica'));
      expect(ids, contains('cctv5+'));
      expect(ids, contains('cctvjilu'));
      expect(ids, contains('cctvchild'));
    });

    test('each channel should have non-empty id and name', () {
      for (final channel in ChannelConstants.channels) {
        expect(channel.id, isNotEmpty);
        expect(channel.name, isNotEmpty);
        expect(channel.liveUrl, isNotEmpty);
      }
    });

    test('isValidChannelId should return true for valid ids', () {
      expect(ChannelConstants.isValidChannelId('cctv1'), isTrue);
      expect(ChannelConstants.isValidChannelId('cctv5'), isTrue);
      expect(ChannelConstants.isValidChannelId('cctvchild'), isTrue);
    });

    test('isValidChannelId should return false for invalid ids', () {
      expect(ChannelConstants.isValidChannelId('invalid'), isFalse);
      expect(ChannelConstants.isValidChannelId(''), isFalse);
    });

    test('getChannelById should return channel for valid id', () {
      final channel = ChannelConstants.getChannelById('cctv1');

      expect(channel, isNotNull);
      expect(channel!.id, 'cctv1');
      expect(channel.name, 'CCTV-1 综合');
    });

    test('getChannelById should return null for invalid id', () {
      final channel = ChannelConstants.getChannelById('invalid');

      expect(channel, isNull);
    });
  });
}
