// ─── lib/features/dashboard/widgets/spending_chart.dart ───
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../providers/dashboard_provider.dart';

class SpendingChart extends ConsumerStatefulWidget {
  const SpendingChart({
    super.key,
    required this.dailySpending,
  });

  final List<DailySpending> dailySpending;

  @override
  ConsumerState<SpendingChart> createState() => _SpendingChartState();
}

class _SpendingChartState extends ConsumerState<SpendingChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final maxAmount = widget.dailySpending
        .fold(0.0, (max, d) => d.amount > max ? d.amount : max);
    final dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white10 : AppColors.border.withOpacity(0.5),
        ),
      ),
      child: Column(
        children: [
          if (_touchedIndex >= 0 && _touchedIndex < widget.dailySpending.length)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '${dayLabels[widget.dailySpending[_touchedIndex].date.weekday - 1]}: ${CurrencyFormatter.display(widget.dailySpending[_touchedIndex].amount)}',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                ),
              ),
            ),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxAmount > 0 ? maxAmount * 1.2 : 100,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor:
                        isDark ? AppColors.darkSurface : AppColors.surface,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        CurrencyFormatter.display(rod.toY),
                        AppTextStyles.bodySmall.copyWith(
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                  touchCallback: (event, response) {
                    setState(() {
                      if (response != null &&
                          response.spot != null &&
                          event is FlTapUpEvent) {
                        _touchedIndex = response.spot!.touchedBarGroupIndex;
                      } else {
                        _touchedIndex = -1;
                      }
                    });
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 ||
                            index >= widget.dailySpending.length) {
                          return const SizedBox.shrink();
                        }
                        final weekday =
                            widget.dailySpending[index].date.weekday;
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            dayLabels[weekday - 1],
                            style: AppTextStyles.bodySmall.copyWith(
                              fontSize: 10,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        );
                      },
                      reservedSize: 28,
                    ),
                  ),
                  leftTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: widget.dailySpending.asMap().entries.map((entry) {
                  final index = entry.key;
                  final spending = entry.value;
                  final isTouched = index == _touchedIndex;

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: spending.amount > 0 ? spending.amount : 1,
                        color: isTouched
                            ? AppColors.accent
                            : AppColors.primary.withOpacity(0.7),
                        width: isTouched ? 24 : 18,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(6),
                        ),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: maxAmount > 0 ? maxAmount * 1.2 : 100,
                          color: (isDark ? Colors.white : AppColors.border)
                              .withOpacity(0.1),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              swapAnimationDuration: const Duration(milliseconds: 500),
              swapAnimationCurve: Curves.easeInOut,
            ),
          ),
        ],
      ),
    );
  }
}
