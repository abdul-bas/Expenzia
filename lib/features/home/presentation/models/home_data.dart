import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';

class HomeData {
  final List<TransactionEntity> transactions;
  final double totalBalance;
  final double totalIncome;
  final double totalExpense;
  final double dailyAverage;
  final double weekly;
  final String greeting;
  final String userName;

  const HomeData({
    required this.transactions,
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpense,
    required this.dailyAverage,
    required this.weekly,
    required this.greeting,
    required this.userName,
  });
}
