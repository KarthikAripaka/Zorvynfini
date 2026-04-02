// ─── lib/data/adapters/transaction_adapter.dart ───
import 'package:hive/hive.dart';
import '../models/transaction.dart';

class ManualTransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 0;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numOfFields; i++) {
      final key = reader.readByte();
      final value = reader.read();
      fields[key] = value;
    }

    return Transaction(
      id: fields[0] as String,
      amount: fields[1] as double,
      type: TransactionType.values[fields[2] as int],
      categoryId: fields[3] as String,
      title: fields[4] as String,
      notes: fields.containsKey(5) ? fields[5] as String? : null,
      date: fields[6] as DateTime,
      createdAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.type.index)
      ..writeByte(3)
      ..write(obj.categoryId)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.date)
      ..writeByte(7)
      ..write(obj.createdAt);
    if (obj.notes != null) {
      writer
        ..writeByte(5)
        ..write(obj.notes);
    }
  }
}
