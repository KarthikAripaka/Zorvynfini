// ─── lib/core/providers/settings_provider.dart ───
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/services/database_service.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences not initialized');
});

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, Settings>((ref) {
  return SettingsNotifier();
});

class Settings {
  const Settings({
    this.themeMode = ThemeMode.system,
    this.currency = 'INR',
    this.monthlyIncome = 0.0,
    this.balance = 0.0,
    this.isOnboardingComplete = false,
    this.userName = 'User',
  });

  final ThemeMode themeMode;
  final String currency;
  final double monthlyIncome;
  final double balance;
  final bool isOnboardingComplete;
  final String userName;

  Settings copyWith({
    ThemeMode? themeMode,
    String? currency,
    double? monthlyIncome,
    double? balance,
    bool? isOnboardingComplete,
    String? userName,
  }) {
    return Settings(
      themeMode: themeMode ?? this.themeMode,
      currency: currency ?? this.currency,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      balance: balance ?? this.balance,
      isOnboardingComplete:
          isOnboardingComplete ?? this.isOnboardingComplete,
      userName: userName ?? this.userName,
    );
  }
}

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier() : super(const Settings()) {
    _load();
  }

  void _load() {
    final db = DatabaseService();
    final settings = db.settings;
    
    state = Settings(
      themeMode: settings.themeMode,
      currency: settings.currency,
      monthlyIncome: settings.monthlyIncome,
      balance: settings.balance,
      isOnboardingComplete: settings.isOnboardingComplete,
      userName: settings.userName,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final db = DatabaseService();
    final current = db.settings;
    await db.saveSettings(current.copyWith(themeMode: mode));
    state = state.copyWith(themeMode: mode);
  }

  Future<void> completeOnboarding({
    required double monthlyIncome,
    required double balance,
    required String userName,
  }) async {
    final db = DatabaseService();
    final current = db.settings;
    await db.saveSettings(current.copyWith(
      monthlyIncome: monthlyIncome,
      balance: balance,
      userName: userName,
      isOnboardingComplete: true,
    ));
    state = state.copyWith(
      monthlyIncome: monthlyIncome,
      balance: balance,
      userName: userName,
      isOnboardingComplete: true,
    );
  }

  Future<void> addToBalance(double amount) async {
    final db = DatabaseService();
    final current = db.settings;
    final newBalance = current.balance + amount;
    await db.saveSettings(current.copyWith(balance: newBalance));
    state = state.copyWith(balance: newBalance);
  }

  Future<void> subtractFromBalance(double amount) async {
    final db = DatabaseService();
    final current = db.settings;
    final newBalance = current.balance - amount;
    await db.saveSettings(current.copyWith(balance: newBalance));
    state = state.copyWith(balance: newBalance);
  }

  Future<void> setUserName(String name) async {
    final db = DatabaseService();
    final current = db.settings;
    await db.saveSettings(current.copyWith(userName: name));
    state = state.copyWith(userName: name);
  }
}