abstract class ExpenseEvent {
  const ExpenseEvent();
}

class LoadExpenseTransactionsEvent extends ExpenseEvent {
  const LoadExpenseTransactionsEvent();
}

class DeleteExpenseTransactionEvent extends ExpenseEvent {
  final int id;

  const DeleteExpenseTransactionEvent(this.id);
}
