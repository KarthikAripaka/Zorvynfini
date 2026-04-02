// ─── lib/features/dashboard/widgets/balance_card.dart ───
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/currency_formatter.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.monthIncome,
    required this.monthExpenses,
  });

  final double totalBalance;
  final double monthIncome;
  final double monthExpenses;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Balance',
            style: AppTextStyles.bodyMedium.copyWith(
              color: (isDark ? AppColors.darkTextSecondary : Colors.white70),
            ),
          ),
          const Gap(8),
          Text(
            CurrencyFormatter.display(totalBalance),
            style: AppTextStyles.displayMedium.copyWith(
              color: isDark ? AppColors.darkTextPrimary : Colors.white,
              fontSize: 36,
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
          const Gap(24),
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  label: 'Income',
                  amount: monthIncome,
                  color: AppColors.success,
                  icon: Icons.arrow_downward,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: (isDark ? Colors.white : Colors.white).withOpacity(0.2),
              ),
              const Gap(16),
              Expanded(
                child: _StatItem(
                  label: 'Expenses',
                  amount: monthExpenses,
                  color: AppColors.danger,
                  icon: Icons.arrow_upward,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.amount,
    required this.color,
    required this.icon,
  });

  final String label;
  final double amount;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, size: 14, color: color),
            ),
            const Gap(8),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
        const Gap(6),
        Text(
          CurrencyFormatter.display(amount),
          style: AppTextStyles.amountMedium.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
