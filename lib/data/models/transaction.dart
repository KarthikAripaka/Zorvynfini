// ─── lib/data/models/transaction.dart ───
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import '../../core/theme/app_colors.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
@HiveType(typeId: 0)
class Transaction with _$Transaction {
  const Transaction._();

  factory Transaction({
    @HiveField(0) required String id,
    @HiveField(1) @JsonKey(name: 'amount') required double amount,
    @HiveField(2) @JsonKey(name: 'type') required TransactionType type,
    @HiveField(3) @JsonKey(name: 'categoryId') required String categoryId,
    @HiveField(4) required String title,
    @HiveField(5) String? notes,
    @HiveField(6) required DateTime date,
    @HiveField(7) required DateTime createdAt,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  @override
  String toString() =>
      'Transaction(id: $id, amount: $amount, type: $type, categoryId: $categoryId, title: $title)';
}

enum TransactionType {
  @JsonValue('income')
  income,
  @JsonValue('expense')
  expense,
}

extension TransactionTypeX on TransactionType {
  bool get isIncome => this == TransactionType.income;
  bool get isExpense => this == TransactionType.expense;
  Color get color {
    return switch (this) {
      TransactionType.income => AppColors.success,
      TransactionType.expense => AppColors.danger,
    };
  }
}
