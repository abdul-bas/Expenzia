import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/features/credit/domain/usecases/add_credit_usecase.dart';
import 'package:expenzia/features/credit/domain/usecases/delete_credit_usecase.dart';
import 'package:expenzia/features/credit/domain/usecases/get_credits_usecase.dart';
import 'package:expenzia/features/credit/presentation/bloc/credit_event.dart';
import 'package:expenzia/features/credit/presentation/bloc/credit_state.dart';
import 'package:expenzia/features/credit/presentation/controllers/credit_controller.dart';

class CreditBloc extends Bloc<CreditEvent, CreditState> {
  final CreditController _controller;

  CreditBloc({
    required GetCreditsUseCase getCreditsUseCase,
    required AddCreditUseCase addCreditUseCase,
    required DeleteCreditUseCase deleteCreditUseCase,
  })  : _controller = CreditController(
          getCreditsUseCase: getCreditsUseCase,
          addCreditUseCase: addCreditUseCase,
          deleteCreditUseCase: deleteCreditUseCase,
        ),
        super(CreditState.initial()) {
    on<LoadCreditsEvent>(_onLoadCredits);
    on<ChangeCreditTypeEvent>(_onChangeCreditType);
    on<ChangePlanTypeEvent>(_onChangePlanType);
    on<ChangeCreditDateEvent>(_onChangeCreditDate);
    on<SubmitCreditEvent>(_onSubmitCredit);
    on<DeleteCreditEvent>(_onDeleteCredit);
  }

  Future<void> _onLoadCredits(
    LoadCreditsEvent event,
    Emitter<CreditState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final list = await _controller.loadCredits();
      emit(state.copyWith(credits: list, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onChangeCreditType(
    ChangeCreditTypeEvent event,
    Emitter<CreditState> emit,
  ) {
    emit(state.copyWith(creditType: event.creditType, clearError: true));
  }

  void _onChangePlanType(
    ChangePlanTypeEvent event,
    Emitter<CreditState> emit,
  ) {
    emit(state.copyWith(planType: event.planType, clearError: true));
  }

  void _onChangeCreditDate(
    ChangeCreditDateEvent event,
    Emitter<CreditState> emit,
  ) {
    emit(state.copyWith(selectedDate: event.date, clearError: true));
  }

  Future<void> _onSubmitCredit(
    SubmitCreditEvent event,
    Emitter<CreditState> emit,
  ) async {
    final cleanAmount = event.amountString
        .replaceAll('\$', '')
        .replaceAll('₹', '')
        .replaceAll(',', '')
        .trim();
    final amount = double.tryParse(cleanAmount);

    if (event.toName.trim().isEmpty) {
      emit(state.copyWith(
        errorMessage: 'Please enter recipient/provider name',
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
      await _controller.saveCredit(
        creditType: state.creditType,
        toName: event.toName,
        amount: amount,
        date: state.selectedDate,
        planType: state.planType,
      );

      final updatedList = await _controller.loadCredits();
      emit(state.copyWith(
        credits: updatedList,
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

  Future<void> _onDeleteCredit(
    DeleteCreditEvent event,
    Emitter<CreditState> emit,
  ) async {
    try {
      await _controller.deleteCreditUseCase(event.id);
      final updatedList = await _controller.loadCredits();
      emit(state.copyWith(credits: updatedList));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
