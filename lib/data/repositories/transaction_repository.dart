// ─── lib/data/repositories/transaction_repository.dart ───
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction.dart';

class TransactionRepository {
  static const String _boxName = 'transactions';

  late final Box<Transaction> _box;

  Future<void> init() async {
    _registerAdapter();
    _box = await Hive.openBox<Transaction>(_boxName);
  }

  void _registerAdapter() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TransactionAdapter());
    }
  }

  // CRUD
  Future<void> add(Transaction transaction) => _box.add(transaction);

  Future<void> update(Transaction transaction) => _box.put(transaction.id, transaction);

  Future<void> delete(String id) => _box.delete(id);

  List<Transaction> get all => _box.values.toList();

  Transaction? getById(String id) => _box.get(id);

  // Queries
  List<Transaction> get recent => _box.values
      .toList()
      .reversed
      .where((t) => t.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
      .take(5)
      .toList();

  double get totalBalance {
    final transactions = all;
    final income = transactions
        .where((t) => t.type.isIncome)
        .map((t) => t.amount)
        .fold(0.0, (sum, a) => sum + a);
    final expenses = transactions
        .where((t) => t.type.isExpense)
        .map((t) => t.amount)
        .fold(0.0, (sum, a) => sum + a);
    return income - expenses;
  }

  List<Transaction> filter({
    TransactionType? type,
    String? categoryId,
    DateTime? from,
    DateTime? to,
  }) {
    return all.where((t) {
      if (type != null && t.type != type) return false;
      if (categoryId != null && t.categoryId != categoryId) return false;
      if (from != null && t.date.isBefore(from)) return false;
      if (to != null && t.date.isAfter(to)) return false;
      return true;
    }).toList();
  }

  // Clear all for testing
  Future<void> clear() => _box.clear();

  Future<void> close() => _box.close();
}

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  throw UnimplementedError('Use TransactionNotifier instead');
});

