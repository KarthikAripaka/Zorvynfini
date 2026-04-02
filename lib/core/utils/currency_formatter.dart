// ─── lib/core/utils/currency_formatter.dart ───
import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final _inrFormatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹ ',
    decimalDigits: 0,
  );

  static final _compactFormatter = NumberFormat.compact(locale: 'en_IN');

  /// Format amount with sign and currency symbol.
  /// Example: +₹ 1,234 | -₹ 567
  static String format(double amount) {
    final sign = amount >= 0 ? '+' : '';
    final absAmount = amount.abs();
    return '$sign${_inrFormatter.format(absAmount)}';
  }

  /// Compact format for charts/insights.
  /// Example: ₹1.2K | ₹15.3M
  static String compact(double amount) {
    return _compactFormatter.format(amount.abs());
  }

  /// Format for large display amounts (no decimals).
  static String display(double amount) {
    return _inrFormatter.format(amount.abs());
  }

  /// Format percentage.
  static String percentage(double value) {
    return '${(value * 100).toStringAsFixed(1)}%';
  }
}
