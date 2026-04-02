// ─── lib/core/widgets/amount_text.dart ───
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/currency_formatter.dart';

class AmountText extends ConsumerWidget {
  const AmountText({
    super.key,
    required this.amount,
    this.style = AmountStyle.large,
    this.isPositive = true,
  });

  final double amount;
  final AmountStyle style;
  final bool isPositive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = isPositive ? AppColors.success : AppColors.danger;
    final textStyle = _getTextStyle(style).copyWith(color: color);

    return Text(
      CurrencyFormatter.format(amount),
      style: textStyle,
      textAlign: TextAlign.center,
    );
  }

  TextStyle _getTextStyle(AmountStyle style) {
    return switch (style) {
      AmountStyle.large => AppTextStyles.amountLarge,
      AmountStyle.medium => AppTextStyles.amountMedium,
      AmountStyle.small => AppTextStyles.amountSmall,
    };
  }
}

enum AmountStyle { large, medium, small }
