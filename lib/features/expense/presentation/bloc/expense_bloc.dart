import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/features/expense/presentation/bloc/expense_event.dart';
import 'package:expenzia/features/expense/presentation/bloc/expense_state.dart';
import 'package:expenzia/features/expense/presentation/controllers/expense_controller.dart';
import 'package:expenzia/features/transaction/domain/usecases/delete_transaction_usecase.dart';
import 'package:expenzia/features/transaction/domain/usecases/get_transactions_usecase.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseController _controller;

  ExpenseBloc({
    required GetTransactionsUseCase getTransactionsUseCase,
    required DeleteTransactionUseCase deleteTransactionUseCase,
  })  : _controller = ExpenseController(
          getTransactionsUseCase: getTransactionsUseCase,
          deleteTransactionUseCase: deleteTransactionUseCase,
        ),
        super(const ExpenseInitial()) {
    on<LoadExpenseTransactionsEvent>(_onLoadTransactions);
    on<DeleteExpenseTransactionEvent>(_onDeleteTransaction);
  }

  Future<void> _onLoadTransactions(
    LoadExpenseTransactionsEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(const ExpenseLoading());
    try {
      final transactions = await _controller.loadTransactions();
      emit(ExpenseLoaded(transactions: transactions));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onDeleteTransaction(
    DeleteExpenseTransactionEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      final updatedList = await _controller.deleteTransaction(event.id);
      emit(ExpenseLoaded(transactions: updatedList));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }
}
