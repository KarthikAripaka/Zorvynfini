// ─── lib/features/insights/providers/insights_provider.dart ───
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/category.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../transactions/providers/transactions_provider.dart';

enum InsightPeriod { thisWeek, thisMonth, lastMonth, custom }

final insightPeriodProvider =
    StateProvider<InsightPeriod>((ref) => InsightPeriod.thisMonth);

final insightsDataProvider = Provider<InsightsData>((ref) {
  final transactions = ref.watch(transactionsProvider);
  final period = ref.watch(insightPeriodProvider);

  final now = DateTime.now();
  late DateTime startDate;
  late DateTime endDate;

  switch (period) {
    case InsightPeriod.thisWeek:
      startDate = now.subtract(Duration(days: now.weekday - 1));
      startDate = DateTime(startDate.year, startDate.month, startDate.day);
      endDate = now;
    case InsightPeriod.thisMonth:
      startDate = DateTime(now.year, now.month, 1);
      endDate = now;
    case InsightPeriod.lastMonth:
      startDate = DateTime(now.year, now.month - 1, 1);
      endDate = DateTime(now.year, now.month, 0);
    case InsightPeriod.custom:
      startDate = DateTime(now.year, now.month, 1);
      endDate = now;
  }

  final periodTransactions = transactions
      .where((t) =>
          t.date.isAfter(
            startDate.subtract(const Duration(days: 1)),
          ) &&
          t.date.isBefore(endDate.add(const Duration(days: 1))))
      .toList();

  final income = periodTransactions
      .where((t) => t.type == TransactionType.income)
      .fold(0.0, (sum, t) => sum + t.amount);

  final expenses = periodTransactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0.0, (sum, t) => sum + t.amount);

  // Category breakdown
  final categoryTotals = <String, double>{};
  final categoryCounts = <String, int>{};
  for (final t in periodTransactions.where(
    (t) => t.type == TransactionType.expense,
  )) {
    categoryTotals[t.categoryId] =
        (categoryTotals[t.categoryId] ?? 0) + t.amount;
    categoryCounts[t.categoryId] = (categoryCounts[t.categoryId] ?? 0) + 1;
  }

  final categoryBreakdowns = categoryTotals.entries.map((e) {
    final category = Category.fromId(e.key);
    return CategoryBreakdown(
      category: category,
      amount: e.value,
      percentage: expenses > 0 ? e.value / expenses : 0,
      transactionCount: categoryCounts[e.key] ?? 0,
    );
  }).toList()
    ..sort((a, b) => b.amount.compareTo(a.amount));

  // Weekly comparison (last 4 weeks)
  final weeklyComparison = <WeeklyData>[];
  for (int w = 3; w >= 0; w--) {
    final weekStart =
        now.subtract(Duration(days: now.weekday - 1 + (w * 7)));
    final weekEnd = weekStart.add(const Duration(days: 7));
    final weekStartDay =
        DateTime(weekStart.year, weekStart.month, weekStart.day);

    final weekIncome = transactions
        .where((t) =>
            t.type == TransactionType.income &&
            t.date.isAfter(
              weekStartDay.subtract(const Duration(days: 1)),
            ) &&
            t.date.isBefore(weekEnd))
        .fold(0.0, (sum, t) => sum + t.amount);

    final weekExpenses = transactions
        .where((t) =>
            t.type == TransactionType.expense &&
            t.date.isAfter(
              weekStartDay.subtract(const Duration(days: 1)),
            ) &&
            t.date.isBefore(weekEnd))
        .fold(0.0, (sum, t) => sum + t.amount);

    weeklyComparison.add(WeeklyData(
      weekLabel: 'W${4 - w}',
      income: weekIncome,
      expenses: weekExpenses,
    ));
  }

  // Smart insights
  final insights = <SmartInsight>[];

  if (categoryBreakdowns.isNotEmpty) {
    final top = categoryBreakdowns.first;
    insights.add(SmartInsight(
      icon: top.category.icon,
      text:
          'Your biggest expense is ${top.category.label} (${CurrencyFormatter.compact(top.amount)})',
      color: top.category.color,
    ));
  }

  if (expenses > 0 && income > 0) {
    final savingRate = ((income - expenses) / income * 100).clamp(0, 100);
    insights.add(SmartInsight(
      icon: Icons.savings,
      text:
          'You\'re saving ${savingRate.toStringAsFixed(0)}% of your income this period',
      color: const Color(0xFF2ECC71),
    ));
  }

  // Day of week analysis
  final daySpending = <int, double>{};
  for (final t in periodTransactions.where(
    (t) => t.type == TransactionType.expense,
  )) {
    daySpending[t.date.weekday] =
        (daySpending[t.date.weekday] ?? 0) + t.amount;
  }
  if (daySpending.isNotEmpty) {
    final topDay = daySpending.entries.reduce(
      (a, b) => a.value > b.value ? a : b,
    );
    final dayNames = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    insights.add(SmartInsight(
      icon: Icons.calendar_today,
      text: '${dayNames[topDay.key]} is your highest spending day',
      color: const Color(0xFFF5A623),
    ));
  }

  // Top transactions
  final topTransactions = List<Transaction>.from(
    periodTransactions.where((t) => t.type == TransactionType.expense),
  )..sort((a, b) => b.amount.compareTo(a.amount));

  return InsightsData(
    totalIncome: income,
    totalExpenses: expenses,
    categoryBreakdowns: categoryBreakdowns,
    weeklyComparison: weeklyComparison,
    insights: insights,
    topTransactions: topTransactions.take(5).toList(),
  );
});

class InsightsData {
  const InsightsData({
    required this.totalIncome,
    required this.totalExpenses,
    required this.categoryBreakdowns,
    required this.weeklyComparison,
    required this.insights,
    required this.topTransactions,
  });

  final double totalIncome;
  final double totalExpenses;
  final List<CategoryBreakdown> categoryBreakdowns;
  final List<WeeklyData> weeklyComparison;
  final List<SmartInsight> insights;
  final List<Transaction> topTransactions;
}

class CategoryBreakdown {
  const CategoryBreakdown({
    required this.category,
    required this.amount,
    required this.percentage,
    required this.transactionCount,
  });

  final Category category;
  final double amount;
  final double percentage;
  final int transactionCount;
}

class WeeklyData {
  const WeeklyData({
    required this.weekLabel,
    required this.income,
    required this.expenses,
  });

  final String weekLabel;
  final double income;
  final double expenses;
}

class SmartInsight {
  const SmartInsight({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;
}
