import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';

abstract class EditTransactionEvent {
  const EditTransactionEvent();
}

class InitEditTransactionEvent extends EditTransactionEvent {
  final TransactionEntity transaction;

  const InitEditTransactionEvent(this.transaction);
}

class ChangeEditTypeEvent extends EditTransactionEvent {
  final bool isIncome;

  const ChangeEditTypeEvent(this.isIncome);
}

class ChangeEditDateEvent extends EditTransactionEvent {
  final DateTime date;

  const ChangeEditDateEvent(this.date);
}

class SubmitEditTransactionEvent extends EditTransactionEvent {
  final int id;
  final String title;
  final String amountString;
  final String? category;

  const SubmitEditTransactionEvent({
    required this.id,
    required this.title,
    required this.amountString,
    this.category,
  });
}
