// ─── lib/data/repositories/goal_repository.dart ───
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/goal.dart';

class GoalRepository {
  static const String _boxName = 'goals';

  late final Box<Goal> _box;

  Future<void> init() async {
    _registerAdapter();
    _box = await Hive.openBox<Goal>(_boxName);
  }

  void _registerAdapter() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GoalAdapter());
    }
  }

  // CRUD
  Future<void> add(Goal goal) => _box.add(goal);

  Future<void> update(Goal goal) => _box.put(goal.id, goal);

  Future<void> delete(String id) => _box.delete(id);

  List<Goal> get all => _box.values.where((g) => g.isActive).toList();

  Goal? getById(String id) => _box.get(id);

  List<Goal> get active => all.where((g) => g.isActive).toList();

  List<Goal> get completed => _box.values.where((g) => g.isCompleted).toList();

  Future<void> clear() => _box.clear();

  Future<void> close() => _box.close();
}

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  throw UnimplementedError('Use GoalNotifier instead');
});
