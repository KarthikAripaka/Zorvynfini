// ─── lib/core/utils/extensions.dart ───
import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color get withOpacity10 => withOpacity(0.1);
  Color get withOpacity20 => withOpacity(0.2);
  Color get withOpacity30 => withOpacity(0.3);
  Color get withOpacity40 => withOpacity(0.4);
  Color get withOpacity50 => withOpacity(0.5);
  Color get withOpacity60 => withOpacity(0.6);
  Color get withOpacity70 => withOpacity(0.7);
  Color get withOpacity80 => withOpacity(0.8);
  Color get withOpacity90 => withOpacity(0.9);
}

extension BrightnessExtension on Brightness {
  bool get isDark => this == Brightness.dark;
  bool get isLight => this == Brightness.light;
}
