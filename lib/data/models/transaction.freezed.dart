// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
mixin _$Transaction {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  @JsonKey(name: 'amount')
  double get amount => throw _privateConstructorUsedError;
  @HiveField(2)
  @JsonKey(name: 'type')
  TransactionType get type => throw _privateConstructorUsedError;
  @HiveField(3)
  @JsonKey(name: 'categoryId')
  String get categoryId => throw _privateConstructorUsedError;
  @HiveField(4)
  String get title => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get notes => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) @JsonKey(name: 'amount') double amount,
      @HiveField(2) @JsonKey(name: 'type') TransactionType type,
      @HiveField(3) @JsonKey(name: 'categoryId') String categoryId,
      @HiveField(4) String title,
      @HiveField(5) String? notes,
      @HiveField(6) DateTime date,
      @HiveField(7) DateTime createdAt});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? type = null,
    Object? categoryId = null,
    Object? title = null,
    Object? notes = freezed,
    Object? date = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$TransactionImplCopyWith(
          _$TransactionImpl value, $Res Function(_$TransactionImpl) then) =
      __$$TransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) @JsonKey(name: 'amount') double amount,
      @HiveField(2) @JsonKey(name: 'type') TransactionType type,
      @HiveField(3) @JsonKey(name: 'categoryId') String categoryId,
      @HiveField(4) String title,
      @HiveField(5) String? notes,
      @HiveField(6) DateTime date,
      @HiveField(7) DateTime createdAt});
}

/// @nodoc
class __$$TransactionImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$TransactionImpl>
    implements _$$TransactionImplCopyWith<$Res> {
  __$$TransactionImplCopyWithImpl(
      _$TransactionImpl _value, $Res Function(_$TransactionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? type = null,
    Object? categoryId = null,
    Object? title = null,
    Object? notes = freezed,
    Object? date = null,
    Object? createdAt = null,
  }) {
    return _then(_$TransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionImpl extends _Transaction {
  _$TransactionImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) @JsonKey(name: 'amount') required this.amount,
      @HiveField(2) @JsonKey(name: 'type') required this.type,
      @HiveField(3) @JsonKey(name: 'categoryId') required this.categoryId,
      @HiveField(4) required this.title,
      @HiveField(5) this.notes,
      @HiveField(6) required this.date,
      @HiveField(7) required this.createdAt})
      : super._();

  factory _$TransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  @JsonKey(name: 'amount')
  final double amount;
  @override
  @HiveField(2)
  @JsonKey(name: 'type')
  final TransactionType type;
  @override
  @HiveField(3)
  @JsonKey(name: 'categoryId')
  final String categoryId;
  @override
  @HiveField(4)
  final String title;
  @override
  @HiveField(5)
  final String? notes;
  @override
  @HiveField(6)
  final DateTime date;
  @override
  @HiveField(7)
  final DateTime createdAt;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, amount, type, categoryId, title, notes, date, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      __$$TransactionImplCopyWithImpl<_$TransactionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionImplToJson(
      this,
    );
  }
}

abstract class _Transaction extends Transaction {
  factory _Transaction(
      {@HiveField(0) required final String id,
      @HiveField(1) @JsonKey(name: 'amount') required final double amount,
      @HiveField(2) @JsonKey(name: 'type') required final TransactionType type,
      @HiveField(3)
      @JsonKey(name: 'categoryId')
      required final String categoryId,
      @HiveField(4) required final String title,
      @HiveField(5) final String? notes,
      @HiveField(6) required final DateTime date,
      @HiveField(7) required final DateTime createdAt}) = _$TransactionImpl;
  _Transaction._() : super._();

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$TransactionImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  @JsonKey(name: 'amount')
  double get amount;
  @override
  @HiveField(2)
  @JsonKey(name: 'type')
  TransactionType get type;
  @override
  @HiveField(3)
  @JsonKey(name: 'categoryId')
  String get categoryId;
  @override
  @HiveField(4)
  String get title;
  @override
  @HiveField(5)
  String? get notes;
  @override
  @HiveField(6)
  DateTime get date;
  @override
  @HiveField(7)
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
