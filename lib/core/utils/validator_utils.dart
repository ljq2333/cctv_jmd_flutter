import 'package:cctv_jmd_flutter/core/constants/channel_constants.dart';

class ValidatorUtils {
  ValidatorUtils._();

  static bool isValidChannelId(String channelId) {
    if (channelId.isEmpty) return false;
    return ChannelConstants.isValidChannelId(channelId);
  }

  static bool isValidDate(String date) {
    if (date.length != 8) return false;
    if (!RegExp(r'^\d{8}$').hasMatch(date)) return false;

    try {
      final year = int.parse(date.substring(0, 4));
      final month = int.parse(date.substring(4, 6));
      final day = int.parse(date.substring(6, 8));

      if (month < 1 || month > 12) return false;
      if (day < 1 || day > 31) return false;

      final dateTime = DateTime(year, month, day);
      return dateTime.year == year &&
          dateTime.month == month &&
          dateTime.day == day;
    } catch (_) {
      return false;
    }
  }

  static bool isValidSearchQuery(String query) {
    if (query.trim().isEmpty) return false;
    return true;
  }
}
