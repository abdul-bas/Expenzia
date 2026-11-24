import 'package:expenzia/features/credit/domain/entities/credit_entity.dart';

class CreditModel extends CreditEntity {
  const CreditModel({
    super.id,
    required super.creditType,
    required super.toName,
    required super.amount,
    required super.dueDate,
    required super.planType,
    required super.createdAt,
  });

  factory CreditModel.fromMap(Map<String, dynamic> map) {
    return CreditModel(
      id: map['id'] as int?,
      creditType: map['credit_type'] as String,
      toName: map['to_name'] as String,
      amount: (map['amount'] as num).toDouble(),
      dueDate: map['due_date'] as String,
      planType: map['plan_type'] as String,
      createdAt: DateTime.tryParse(map['created_at'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'credit_type': creditType,
      'to_name': toName,
      'amount': amount,
      'due_date': dueDate,
      'plan_type': planType,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory CreditModel.fromEntity(CreditEntity entity) {
    return CreditModel(
      id: entity.id,
      creditType: entity.creditType,
      toName: entity.toName,
      amount: entity.amount,
      dueDate: entity.dueDate,
      planType: entity.planType,
      createdAt: entity.createdAt,
    );
  }
}
