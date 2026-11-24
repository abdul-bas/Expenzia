import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';

class EditTransactionState {
  final TransactionEntity? initialTransaction;
  final bool isIncome;
  final DateTime selectedDate;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const EditTransactionState({
    this.initialTransaction,
    required this.isIncome,
    required this.selectedDate,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  factory EditTransactionState.fromTransaction(TransactionEntity transaction) {
    return EditTransactionState(
      initialTransaction: transaction,
      isIncome: transaction.isIncome,
      selectedDate: transaction.createdAt,
      isSubmitting: false,
      isSuccess: false,
      errorMessage: null,
    );
  }

  EditTransactionState copyWith({
    TransactionEntity? initialTransaction,
    bool? isIncome,
    DateTime? selectedDate,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
  }) {
    return EditTransactionState(
      initialTransaction: initialTransaction ?? this.initialTransaction,
      isIncome: isIncome ?? this.isIncome,
      selectedDate: selectedDate ?? this.selectedDate,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
