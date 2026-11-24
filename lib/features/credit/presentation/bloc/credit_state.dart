import 'package:expenzia/features/credit/domain/entities/credit_entity.dart';

class CreditState {
  final List<CreditEntity> credits;
  final String creditType;
  final String planType;
  final DateTime selectedDate;
  final bool isLoading;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const CreditState({
    required this.credits,
    required this.creditType,
    required this.planType,
    required this.selectedDate,
    this.isLoading = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  factory CreditState.initial() {
    return CreditState(
      credits: const [],
      creditType: 'Subscriptions',
      planType: 'Monthly',
      selectedDate: DateTime.now(),
      isLoading: false,
      isSubmitting: false,
      isSuccess: false,
      errorMessage: null,
    );
  }

  CreditState copyWith({
    List<CreditEntity>? credits,
    String? creditType,
    String? planType,
    DateTime? selectedDate,
    bool? isLoading,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CreditState(
      credits: credits ?? this.credits,
      creditType: creditType ?? this.creditType,
      planType: planType ?? this.planType,
      selectedDate: selectedDate ?? this.selectedDate,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
