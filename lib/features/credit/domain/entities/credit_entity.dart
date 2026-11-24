class CreditEntity {
  final int? id;
  final String creditType;
  final String toName;
  final double amount;
  final String dueDate;
  final String planType;
  final DateTime createdAt;

  const CreditEntity({
    this.id,
    required this.creditType,
    required this.toName,
    required this.amount,
    required this.dueDate,
    required this.planType,
    required this.createdAt,
  });

  CreditEntity copyWith({
    int? id,
    String? creditType,
    String? toName,
    double? amount,
    String? dueDate,
    String? planType,
    DateTime? createdAt,
  }) {
    return CreditEntity(
      id: id ?? this.id,
      creditType: creditType ?? this.creditType,
      toName: toName ?? this.toName,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      planType: planType ?? this.planType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
