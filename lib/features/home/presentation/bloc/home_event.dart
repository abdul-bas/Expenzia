import 'package:expenzia/domain/entities/transaction_entity.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class LoadHomeDataEvent extends HomeEvent {
  const LoadHomeDataEvent();
}

class AddTransactionEvent extends HomeEvent {
  final TransactionEntity transaction;

  const AddTransactionEvent(this.transaction);
}

class DeleteTransactionEvent extends HomeEvent {
  final int id;

  const DeleteTransactionEvent(this.id);
}
