class TransactionState {
  final bool isIncome;
  final DateTime selectedDate;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const TransactionState({
    required this.isIncome,
    required this.selectedDate,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  factory TransactionState.initial() {
    return TransactionState(
      isIncome: false, // Default is Expense matching Figma
      selectedDate: DateTime.now(),
      isSubmitting: false,
      isSuccess: false,
      errorMessage: null,
    );
  }

  TransactionState copyWith({
    bool? isIncome,
    DateTime? selectedDate,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TransactionState(
      isIncome: isIncome ?? this.isIncome,
      selectedDate: selectedDate ?? this.selectedDate,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
