class FormatUtils {
  FormatUtils._();

  static String formatDuration(int seconds) {
    if (seconds <= 0) return '0分钟';

    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;

    if (hours > 0) {
      return '$hours小时$minutes分钟';
    }
    return '$minutes分钟';
  }

  static String formatCacheSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / 1048576).toStringAsFixed(1)} MB';
  }

  static String formatNumber(int number) {
    final str = number.toString();
    final buffer = StringBuffer();
    final digits = str.split('').reversed.toList();

    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(digits[i]);
    }

    return buffer.toString().split('').reversed.join();
  }
}
