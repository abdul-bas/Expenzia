import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';

abstract class ExpenseState {
  const ExpenseState();
}

class ExpenseInitial extends ExpenseState {
  const ExpenseInitial();
}

class ExpenseLoading extends ExpenseState {
  const ExpenseLoading();
}

class ExpenseLoaded extends ExpenseState {
  final List<TransactionEntity> transactions;

  const ExpenseLoaded({required this.transactions});
}

class ExpenseError extends ExpenseState {
  final String message;

  const ExpenseError(this.message);
}
