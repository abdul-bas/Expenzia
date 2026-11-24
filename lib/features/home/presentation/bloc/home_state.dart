import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<TransactionEntity> transactions;
  final double totalBalance;
  final double totalIncome;
  final double totalExpense;
  final double dailyAverage;
  final double weekly;
  final String greeting;
  final String userName;
  final int selectedNavIndex;

  const HomeLoaded({
    required this.transactions,
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpense,
    required this.dailyAverage,
    required this.weekly,
    this.greeting = 'Good afternoon,',
    this.userName = 'Sahal Muhammed',
    this.selectedNavIndex = 0,
  });

  HomeLoaded copyWith({
    List<TransactionEntity>? transactions,
    double? totalBalance,
    double? totalIncome,
    double? totalExpense,
    double? dailyAverage,
    double? weekly,
    String? greeting,
    String? userName,
    int? selectedNavIndex,
  }) {
    return HomeLoaded(
      transactions: transactions ?? this.transactions,
      totalBalance: totalBalance ?? this.totalBalance,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      dailyAverage: dailyAverage ?? this.dailyAverage,
      weekly: weekly ?? this.weekly,
      greeting: greeting ?? this.greeting,
      userName: userName ?? this.userName,
      selectedNavIndex: selectedNavIndex ?? this.selectedNavIndex,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}
