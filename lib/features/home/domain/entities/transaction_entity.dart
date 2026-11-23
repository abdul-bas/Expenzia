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
}
