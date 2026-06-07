import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/data/models/favorite_model.dart';

void main() {
  group('Favorite', () {
    test('should create from JSON', () {
      final json = {
        'id': 'fav_1',
        'channelId': 'cctv1',
        'channelName': 'CCTV-1',
        'title': '早间新闻',
        'startTime': 1780763470,
        'date': '20260607',
      };

      final favorite = Favorite.fromJson(json);

      expect(favorite.id, 'fav_1');
      expect(favorite.channelId, 'cctv1');
      expect(favorite.title, '早间新闻');
    });

    test('should support copyWith', () {
      const favorite = Favorite(
        id: 'fav_1',
        channelId: 'cctv1',
        channelName: 'CCTV-1',
        title: 'News',
        startTime: 100,
        date: '20260607',
      );

      final copied = favorite.copyWith(title: 'Updated');

      expect(copied.title, 'Updated');
      expect(copied.id, 'fav_1');
    });
  });
}
