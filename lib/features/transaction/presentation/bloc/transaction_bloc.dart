import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/features/transaction/domain/usecases/add_transaction_usecase.dart';
import 'package:expenzia/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:expenzia/features/transaction/presentation/bloc/transaction_state.dart';
import 'package:expenzia/features/transaction/presentation/controllers/transaction_controller.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionController _controller;

  TransactionBloc({
    required AddTransactionUseCase addTransactionUseCase,
  })  : _controller = TransactionController(
          addTransactionUseCase: addTransactionUseCase,
        ),
        super(TransactionState.initial()) {
    on<ChangeTransactionTypeEvent>(_onChangeTransactionType);
    on<ChangeTransactionDateEvent>(_onChangeTransactionDate);
    on<SubmitTransactionEvent>(_onSubmitTransaction);
    on<ResetTransactionEvent>(_onResetTransaction);
  }

  void _onChangeTransactionType(
    ChangeTransactionTypeEvent event,
    Emitter<TransactionState> emit,
  ) {
    emit(state.copyWith(isIncome: event.isIncome, clearError: true));
  }

  void _onChangeTransactionDate(
    ChangeTransactionDateEvent event,
    Emitter<TransactionState> emit,
  ) {
    emit(state.copyWith(selectedDate: event.date, clearError: true));
  }

  Future<void> _onSubmitTransaction(
    SubmitTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final cleanAmount = event.amountString
        .replaceAll('\$', '')
        .replaceAll(',', '')
        .trim();
    final amount = double.tryParse(cleanAmount);

    if (event.title.trim().isEmpty) {
      emit(state.copyWith(
        errorMessage: 'Please enter a name for the transaction',
      ));
      return;
    }

    if (amount == null || amount <= 0) {
      emit(state.copyWith(
        errorMessage: 'Please enter a valid positive amount',
      ));
      return;
    }

    emit(state.copyWith(isSubmitting: true, clearError: true));

    try {
      await _controller.saveTransaction(
        title: event.title,
        amount: amount,
        isIncome: state.isIncome,
        date: state.selectedDate,
        category: event.category,
      );

      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  void _onResetTransaction(
    ResetTransactionEvent event,
    Emitter<TransactionState> emit,
  ) {
    emit(TransactionState.initial());
  }
}
