import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';
import 'package:expenzia/features/transaction/domain/usecases/update_transaction_usecase.dart';
import 'package:expenzia/features/transaction/presentation/bloc/edit_transaction_event.dart';
import 'package:expenzia/features/transaction/presentation/bloc/edit_transaction_state.dart';
import 'package:expenzia/features/transaction/presentation/controllers/edit_transaction_controller.dart';

class EditTransactionBloc
    extends Bloc<EditTransactionEvent, EditTransactionState> {
  final EditTransactionController _controller;

  EditTransactionBloc({
    required UpdateTransactionUseCase updateTransactionUseCase,
    required TransactionEntity initialTransaction,
  })  : _controller = EditTransactionController(
          updateTransactionUseCase: updateTransactionUseCase,
        ),
        super(EditTransactionState.fromTransaction(initialTransaction)) {
    on<InitEditTransactionEvent>(_onInit);
    on<ChangeEditTypeEvent>(_onChangeType);
    on<ChangeEditDateEvent>(_onChangeDate);
    on<SubmitEditTransactionEvent>(_onSubmit);
  }

  void _onInit(
    InitEditTransactionEvent event,
    Emitter<EditTransactionState> emit,
  ) {
    emit(EditTransactionState.fromTransaction(event.transaction));
  }

  void _onChangeType(
    ChangeEditTypeEvent event,
    Emitter<EditTransactionState> emit,
  ) {
    emit(state.copyWith(isIncome: event.isIncome, clearError: true));
  }

  void _onChangeDate(
    ChangeEditDateEvent event,
    Emitter<EditTransactionState> emit,
  ) {
    emit(state.copyWith(selectedDate: event.date, clearError: true));
  }

  Future<void> _onSubmit(
    SubmitEditTransactionEvent event,
    Emitter<EditTransactionState> emit,
  ) async {
    final cleanAmount = event.amountString
        .replaceAll('\$', '')
        .replaceAll('₹', '')
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
      await _controller.updateTransaction(
        id: event.id,
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
}
