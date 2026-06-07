class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.cntv.cn';
  static const String epgEndpoint = '/epg/getEpgInfoByChannelNew';
  static const String serviceId = 'tvcctv';
  static const String defaultFormat = 'jsonp';
  static const String defaultCallback = 'setItem1';

  static const int connectTimeout = 15000;
  static const int receiveTimeout = 15000;

  static const int cacheExpirationDays = 7;

  static const String epgFullUrl = '$baseUrl$epgEndpoint';
}
