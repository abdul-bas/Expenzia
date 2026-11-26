import 'package:flutter/material.dart';
import 'package:expenzia/core/routes/app_routes.dart';
import 'package:expenzia/features/credit/presentation/pages/credit_page.dart';
import 'package:expenzia/features/expense/presentation/pages/add_expense_page.dart';
import 'package:expenzia/features/home/presentation/pages/home_page.dart';
import 'package:expenzia/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:expenzia/features/profile/presentation/pages/profile_page.dart';
import 'package:expenzia/features/splash/presentation/pages/splash_page.dart';
import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';
import 'package:expenzia/features/transaction/presentation/pages/edit_transaction_page.dart';
import 'package:expenzia/features/transaction/presentation/pages/transaction_page.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingPage());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.transaction:
        return MaterialPageRoute(builder: (_) => TransactionPage());
      case AppRoutes.addExpense:
        return MaterialPageRoute(builder: (_) => const AddExpensePage());
      case AppRoutes.credit:
        return MaterialPageRoute(builder: (_) => CreditPage());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case AppRoutes.editTransaction:
        final transaction = settings.arguments as TransactionEntity;
        return MaterialPageRoute(
          builder: (_) => EditTransactionPage(transaction: transaction),
        );
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
