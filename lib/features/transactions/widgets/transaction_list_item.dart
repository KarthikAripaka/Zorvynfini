// ─── lib/features/transactions/widgets/transaction_list_item.dart ───
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_utils.dart' as app_dates;
import '../../../data/models/transaction.dart';
import '../../../data/models/category.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    super.key,
    required this.transaction,
    this.onTap,
    this.onDelete,
  });

  final Transaction transaction;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final category = Category.fromId(transaction.categoryId);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dismissible(
      key: ValueKey(transaction.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete?.call(),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Delete transaction?'),
            content:
                Text('This will permanently delete "${transaction.title}"'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: TextButton.styleFrom(foregroundColor: AppColors.danger),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.danger,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? Colors.white10 : AppColors.border.withOpacity(0.5),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  category.icon,
                  color: category.color,
                  size: 22,
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(2),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: category.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            category.label,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: category.color,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const Gap(8),
                        Text(
                          app_dates.AppDateUtils.time(transaction.date),
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                '${transaction.type == TransactionType.income ? '+' : '-'}${CurrencyFormatter.display(transaction.amount)}',
                style: AppTextStyles.amountSmall.copyWith(
                  color: transaction.type == TransactionType.income
                      ? AppColors.success
                      : AppColors.danger,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
