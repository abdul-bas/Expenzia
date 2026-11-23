import 'package:expenzia/features/home/data/models/home_data.dart';
import 'package:expenzia/features/home/domain/entities/transaction_entity.dart';
import 'package:expenzia/features/home/domain/usecases/add_transaction_usecase.dart';
import 'package:expenzia/features/home/domain/usecases/delete_transaction_usecase.dart';
import 'package:expenzia/features/home/domain/usecases/get_transactions_usecase.dart';


class HomeController {
  final GetTransactionsUseCase _getTransactions;
  final AddTransactionUseCase _addTransaction;
  final DeleteTransactionUseCase _deleteTransaction;

  HomeController({
    required GetTransactionsUseCase getTransactionsUseCase,
    required AddTransactionUseCase addTransactionUseCase,
    required DeleteTransactionUseCase deleteTransactionUseCase,
  })  : _getTransactions = getTransactionsUseCase,
        _addTransaction = addTransactionUseCase,
        _deleteTransaction = deleteTransactionUseCase;

  /// Fetches all transactions and computes totals.
  Future<HomeData> loadHomeData() async {
    final transactions = await _getTransactions();

    double income = 0.0;
    double expense = 0.0;

    for (final tx in transactions) {
      if (tx.isIncome) {
        income += tx.amount;
      } else {
        expense += tx.amount;
      }
    }

    final totalBalance = income - expense;
    final dailyAverage = expense > 0 ? (expense / 7 * 5) : 0.0;
    final weekly = expense > 0 ? expense : 0.0;

    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good morning,'
        : hour < 17
            ? 'Good afternoon,'
            : 'Good evening,';

    return HomeData(
      transactions: transactions,
      totalBalance: totalBalance,
      totalIncome: income,
      totalExpense: expense,
      dailyAverage: dailyAverage,
      weekly: weekly,
      greeting: greeting,
      userName: 'Sahal Muhammed',
    );
  }

  /// Persists a new transaction and returns refreshed [HomeData].
  Future<HomeData> addTransaction(TransactionEntity transaction) async {
    await _addTransaction(transaction);
    return loadHomeData();
  }

  /// Deletes a transaction by [id] and returns refreshed [HomeData].
  Future<HomeData> deleteTransaction(int id) async {
    await _deleteTransaction(id);
    return loadHomeData();
  }
}
