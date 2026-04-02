// ─── lib/core/utils/date_utils.dart ───
import 'package:intl/intl.dart';

class AppDateUtils {
  static const List<String> _weekdaysShort = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  static const List<String> _monthsShort = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  /// Format date as "Today", "Yesterday", or "MMM dd"
  static String relativeDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final itemDate = DateTime(date.year, date.month, date.day);

    if (itemDate == today) {
      return 'Today';
    } else if (itemDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else if (date.isAfter(today.subtract(const Duration(days: 6)))) {
      return _weekdaysShort[date.weekday - 1];
    } else {
      return '${_monthsShort[date.month - 1]} ${date.day}';
    }
  }

  /// Format time as "6:30 PM"
  static String time(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }

  /// Format full date as "Jan 15, 2024"
  static String fullDate(DateTime date) {
    return DateFormat('MMM d, y').format(date);
  }

  /// Days remaining until deadline
  static String daysRemaining(DateTime deadline) {
    final days = deadline.difference(DateTime.now()).inDays;
    if (days <= 0) return 'Overdue';
    if (days == 1) return '1 day left';
    return '$days days left';
  }

  /// Start of week (Monday)
  static DateTime startOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  /// End of week (Sunday)
  static DateTime endOfWeek(DateTime date) {
    return date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
  }

  /// Is same week
  static bool isSameWeek(DateTime date1, DateTime date2) {
    return startOfWeek(date1) == startOfWeek(date2);
  }

  /// Is same month
  static bool isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }
}

