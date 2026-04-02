// ─── lib/core/widgets/category_chip.dart ───
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../data/models/category.dart';
import '../utils/extensions.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    this.size = ChipSize.medium,
    this.onTap,
  });

  final Category category;
  final ChipSize size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: _padding,
        decoration: BoxDecoration(
          color: category.color.withOpacity10,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: category.color.withOpacity30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              category.icon,
              size: _iconSize,
              color: category.color,
            ),
            const Gap(4),
            Text(
              category.label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: category.color,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  EdgeInsetsGeometry get _padding => switch (size) {
        ChipSize.small =>
          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ChipSize.medium =>
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ChipSize.large =>
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      };

  double get _iconSize => switch (size) {
        ChipSize.small => 12,
        ChipSize.medium => 16,
        ChipSize.large => 20,
      };
}

enum ChipSize { small, medium, large }
