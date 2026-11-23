import 'package:expenzia/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    super.id,
    required super.title,
    required super.amount,
    required super.isIncome,
    required super.category,
    required super.date,
    required super.createdAt,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      isIncome: (map['is_income'] as int) == 1,
      category: map['category'] as String,
      date: map['date'] as String,
      createdAt: DateTime.tryParse(map['created_at'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'amount': amount,
      'is_income': isIncome ? 1 : 0,
      'category': category,
      'date': date,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      title: entity.title,
      amount: entity.amount,
      isIncome: entity.isIncome,
      category: entity.category,
      date: entity.date,
      createdAt: entity.createdAt,
    );
  }
}
