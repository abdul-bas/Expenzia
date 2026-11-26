import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/core/constants/app_strings.dart';
import 'package:expenzia/core/routes/app_router.dart';
import 'package:expenzia/core/routes/app_routes.dart';
import 'package:expenzia/core/theme/app_theme.dart';
import 'package:expenzia/features/credit/data/repositories/credit_repository_impl.dart';
import 'package:expenzia/features/credit/domain/usecases/add_credit_usecase.dart';
import 'package:expenzia/features/credit/domain/usecases/delete_credit_usecase.dart';
import 'package:expenzia/features/credit/domain/usecases/get_credits_usecase.dart';
import 'package:expenzia/features/credit/presentation/bloc/credit_bloc.dart';
import 'package:expenzia/features/credit/presentation/bloc/credit_event.dart';
import 'package:expenzia/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:expenzia/features/expense/presentation/bloc/expense_event.dart';
import 'package:expenzia/features/home/presentation/bloc/home_bloc.dart';
import 'package:expenzia/features/home/presentation/bloc/home_event.dart';
import 'package:expenzia/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:expenzia/features/profile/domain/usecases/clear_storage_usecase.dart';
import 'package:expenzia/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:expenzia/features/profile/domain/usecases/update_profile_name_usecase.dart';
import 'package:expenzia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:expenzia/features/profile/presentation/bloc/profile_event.dart';
import 'package:expenzia/features/splash/presentation/pages/splash_page.dart';
import 'package:expenzia/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:expenzia/features/transaction/domain/usecases/add_transaction_usecase.dart';
import 'package:expenzia/features/transaction/domain/usecases/delete_transaction_usecase.dart';
import 'package:expenzia/features/transaction/domain/usecases/get_transactions_usecase.dart';
import 'package:expenzia/features/transaction/domain/usecases/update_transaction_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ExpenziaApp());
}

class ExpenziaApp extends StatelessWidget {
  const ExpenziaApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Transaction Repository & UseCases
    final transactionRepository = TransactionRepositoryImpl();
    final getTransactionsUseCase = GetTransactionsUseCase(transactionRepository);
    final addTransactionUseCase = AddTransactionUseCase(transactionRepository);
    final updateTransactionUseCase = UpdateTransactionUseCase(transactionRepository);
    final deleteTransactionUseCase = DeleteTransactionUseCase(transactionRepository);

    // Credit Repository & UseCases
    final creditRepository = CreditRepositoryImpl();
    final getCreditsUseCase = GetCreditsUseCase(creditRepository);
    final addCreditUseCase = AddCreditUseCase(creditRepository);
    final deleteCreditUseCase = DeleteCreditUseCase(creditRepository);

    // Profile Repository & UseCases
    final profileRepository = ProfileRepositoryImpl();
    final getProfileUseCase = GetProfileUseCase(profileRepository);
    final updateProfileNameUseCase = UpdateProfileNameUseCase(profileRepository);
    final clearStorageUseCase = ClearStorageUseCase(profileRepository);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AddTransactionUseCase>.value(
          value: addTransactionUseCase,
        ),
        RepositoryProvider<UpdateTransactionUseCase>.value(
          value: updateTransactionUseCase,
        ),
        RepositoryProvider<GetTransactionsUseCase>.value(
          value: getTransactionsUseCase,
        ),
        RepositoryProvider<DeleteTransactionUseCase>.value(
          value: deleteTransactionUseCase,
        ),
        RepositoryProvider<GetCreditsUseCase>.value(
          value: getCreditsUseCase,
        ),
        RepositoryProvider<AddCreditUseCase>.value(
          value: addCreditUseCase,
        ),
        RepositoryProvider<DeleteCreditUseCase>.value(
          value: deleteCreditUseCase,
        ),
        RepositoryProvider<GetProfileUseCase>.value(
          value: getProfileUseCase,
        ),
        RepositoryProvider<UpdateProfileNameUseCase>.value(
          value: updateProfileNameUseCase,
        ),
        RepositoryProvider<ClearStorageUseCase>.value(
          value: clearStorageUseCase,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (_) => HomeBloc(
              getTransactionsUseCase: getTransactionsUseCase,
              addTransactionUseCase: addTransactionUseCase,
              deleteTransactionUseCase: deleteTransactionUseCase,
            )..add(const LoadHomeDataEvent()),
          ),
          BlocProvider<ExpenseBloc>(
            create: (_) => ExpenseBloc(
              getTransactionsUseCase: getTransactionsUseCase,
              deleteTransactionUseCase: deleteTransactionUseCase,
            )..add(const LoadExpenseTransactionsEvent()),
          ),
          BlocProvider<CreditBloc>(
            create: (_) => CreditBloc(
              getCreditsUseCase: getCreditsUseCase,
              addCreditUseCase: addCreditUseCase,
              deleteCreditUseCase: deleteCreditUseCase,
            )..add(const LoadCreditsEvent()),
          ),
          BlocProvider<ProfileBloc>(
            create: (_) => ProfileBloc(
              getProfileUseCase: getProfileUseCase,
              updateProfileNameUseCase: updateProfileNameUseCase,
              clearStorageUseCase: clearStorageUseCase,
            )..add(const LoadProfileEvent()),
          ),
        ],
        child: MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
          home: SplashPage(),
        ),
      ),
    );
  }
}
