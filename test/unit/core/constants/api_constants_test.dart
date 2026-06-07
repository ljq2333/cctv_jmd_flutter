import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/constants/api_constants.dart';

void main() {
  group('ApiConstants', () {
    test('baseUrl should be CNTV API endpoint', () {
      expect(ApiConstants.baseUrl, 'https://api.cntv.cn');
    });

    test('epgEndpoint should be correct path', () {
      expect(ApiConstants.epgEndpoint, '/epg/getEpgInfoByChannelNew');
    });

    test('serviceId should be tvcctv', () {
      expect(ApiConstants.serviceId, 'tvcctv');
    });

    test('defaultFormat should be jsonp', () {
      expect(ApiConstants.defaultFormat, 'jsonp');
    });

    test('defaultCallback should be setItem1', () {
      expect(ApiConstants.defaultCallback, 'setItem1');
    });

    test('connectTimeout should be reasonable', () {
      expect(ApiConstants.connectTimeout, equals(15000));
    });

    test('receiveTimeout should be reasonable', () {
      expect(ApiConstants.receiveTimeout, equals(15000));
    });

    test('cacheExpirationDays should be 7', () {
      expect(ApiConstants.cacheExpirationDays, equals(7));
    });

    test('epgFullUrl should combine base and endpoint', () {
      expect(
        ApiConstants.epgFullUrl,
        'https://api.cntv.cn/epg/getEpgInfoByChannelNew',
      );
    });
  });
}
