class AppDateUtils {
  AppDateUtils._();

  static String formatToApiDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year$month$day';
  }

  static String formatToDisplayDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year年$month月$day日';
  }

  static String formatToTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isCurrentProgram(DateTime startTime, DateTime endTime) {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  static List<DateTime> getDateRange() {
    final now = DateTime.now();
    final startDate = now.subtract(const Duration(days: 30));
    return List.generate(
      7,
      (index) => startDate.add(Duration(days: index)),
    );
  }
}
