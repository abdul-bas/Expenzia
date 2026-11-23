import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/core/constants/app_strings.dart';
import 'package:expenzia/core/routes/app_router.dart';
import 'package:expenzia/core/routes/app_routes.dart';
import 'package:expenzia/core/theme/app_theme.dart';
import 'package:expenzia/data/repositories/transaction_repository_impl.dart';
import 'package:expenzia/domain/usecases/add_transaction_usecase.dart';
import 'package:expenzia/domain/usecases/delete_transaction_usecase.dart';
import 'package:expenzia/domain/usecases/get_transactions_usecase.dart';
import 'package:expenzia/features/home/presentation/bloc/home_bloc.dart';
import 'package:expenzia/features/home/presentation/bloc/home_event.dart';
import 'package:expenzia/features/splash/presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ExpenziaApp());
}

class ExpenziaApp extends StatelessWidget {
  const ExpenziaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = TransactionRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(
            getTransactionsUseCase: GetTransactionsUseCase(repository),
            addTransactionUseCase: AddTransactionUseCase(repository),
            deleteTransactionUseCase: DeleteTransactionUseCase(repository),
          )..add(const LoadHomeDataEvent()),
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
    );
  }
}
