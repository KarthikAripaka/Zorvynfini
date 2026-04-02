// ─── lib/features/dashboard/widgets/goals_preview.dart ───
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/models/goal.dart';

class GoalsPreview extends StatelessWidget {
  const GoalsPreview({
    super.key,
    required this.goals,
  });

  final List<dynamic> goals;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: goals.length,
        separatorBuilder: (_, __) => const Gap(12),
        itemBuilder: (context, index) {
          final goal = goals[index] as Goal;
          return _GoalPreviewCard(goal: goal);
        },
      ),
    );
  }
}

class _GoalPreviewCard extends StatelessWidget {
  const _GoalPreviewCard({required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = goal.progress.clamp(0.0, 1.0);
    final progressColor = progress < 0.5
        ? AppColors.accent
        : progress < 1.0
            ? AppColors.primary
            : AppColors.success;

    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white10 : AppColors.border.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                goal.type.icon,
                size: 18,
                color: progressColor,
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  goal.title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: progressColor.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 6,
            ),
          ),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                goal.progressText,
                style: AppTextStyles.bodySmall.copyWith(
                  color: progressColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                CurrencyFormatter.compact(goal.targetAmount),
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
