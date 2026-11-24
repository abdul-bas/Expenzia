class TransactionEntity {
  final int? id;
  final String title;
  final double amount;
  final bool isIncome;
  final String category;
  final String date;
  final DateTime createdAt;

  const TransactionEntity({
    this.id,
    required this.title,
    required this.amount,
    required this.isIncome,
    required this.category,
    required this.date,
    required this.createdAt,
  });

  TransactionEntity copyWith({
    int? id,
    String? title,
    double? amount,
    bool? isIncome,
    String? category,
    String? date,
    DateTime? createdAt,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      isIncome: isIncome ?? this.isIncome,
      category: category ?? this.category,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
