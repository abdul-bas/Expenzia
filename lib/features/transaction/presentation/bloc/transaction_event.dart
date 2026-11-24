abstract class TransactionEvent {
  const TransactionEvent();
}

class ChangeTransactionTypeEvent extends TransactionEvent {
  final bool isIncome;

  const ChangeTransactionTypeEvent(this.isIncome);
}

class ChangeTransactionDateEvent extends TransactionEvent {
  final DateTime date;

  const ChangeTransactionDateEvent(this.date);
}

class SubmitTransactionEvent extends TransactionEvent {
  final String title;
  final String amountString;
  final String? category;

  const SubmitTransactionEvent({
    required this.title,
    required this.amountString,
    this.category,
  });
}

class ResetTransactionEvent extends TransactionEvent {
  const ResetTransactionEvent();
}
