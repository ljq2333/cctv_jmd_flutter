class CalendarEventFormatter {
  static String formatTitle(String channelName, String programTitle) {
    return '[$channelName] $programTitle';
  }

  static String formatDescription({
    required String channelName,
    required String programTitle,
    required String showTime,
    required String liveUrl,
  }) {
    return '''
节目: $programTitle
频道: $channelName
时间: $showTime
直播: $liveUrl
''';
  }
}
