// ─── lib/core/widgets/empty_state.dart ───
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: (isDark ? AppColors.darkPrimary : AppColors.primary)
                    .withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: isDark ? AppColors.darkPrimary : AppColors.primary,
              ),
            ),
            const Gap(24),
            Text(
              title,
              style: AppTextStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            Text(
              subtitle,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const Gap(24),
              ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add, size: 20),
                label: Text(actionLabel!),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDark ? AppColors.darkPrimary : AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
