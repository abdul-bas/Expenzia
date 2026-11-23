import 'package:expenzia/features/home/data/models/home_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/features/home/domain/usecases/add_transaction_usecase.dart';
import 'package:expenzia/features/home/domain/usecases/delete_transaction_usecase.dart';
import 'package:expenzia/features/home/domain/usecases/get_transactions_usecase.dart';
import 'package:expenzia/features/home/presentation/bloc/home_event.dart';
import 'package:expenzia/features/home/presentation/bloc/home_state.dart';
import 'package:expenzia/features/home/presentation/controllers/home_controller.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeController _controller;

  HomeBloc({
    required GetTransactionsUseCase getTransactionsUseCase,
    required AddTransactionUseCase addTransactionUseCase,
    required DeleteTransactionUseCase deleteTransactionUseCase,
  })  : _controller = HomeController(
          getTransactionsUseCase: getTransactionsUseCase,
          addTransactionUseCase: addTransactionUseCase,
          deleteTransactionUseCase: deleteTransactionUseCase,
        ),
        super(const HomeInitial()) {
    on<LoadHomeDataEvent>(_onLoadHomeData);
    on<AddTransactionEvent>(_onAddTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<ChangeBottomNavIndexEvent>(_onChangeBottomNavIndex);
  }

  /// Preserves the current nav index across data reloads.
  int get _currentNavIndex {
    final s = state;
    return s is HomeLoaded ? s.selectedNavIndex : 0;
  }

  HomeLoaded _dataToState(HomeData data, {int? navIndex}) {
    return HomeLoaded(
      transactions: data.transactions,
      totalBalance: data.totalBalance,
      totalIncome: data.totalIncome,
      totalExpense: data.totalExpense,
      dailyAverage: data.dailyAverage,
      weekly: data.weekly,
      greeting: data.greeting,
      userName: data.userName,
      selectedNavIndex: navIndex ?? _currentNavIndex,
    );
  }

  Future<void> _onLoadHomeData(
    LoadHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final data = await _controller.loadHomeData();
      emit(_dataToState(data));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onAddTransaction(
    AddTransactionEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final data = await _controller.addTransaction(event.transaction);
      emit(_dataToState(data));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final data = await _controller.deleteTransaction(event.id);
      emit(_dataToState(data));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void _onChangeBottomNavIndex(
    ChangeBottomNavIndexEvent event,
    Emitter<HomeState> emit,
  ) {
    final s = state;
    if (s is HomeLoaded) {
      emit(s.copyWith(selectedNavIndex: event.index));
    }
  }
}
