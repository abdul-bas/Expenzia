import 'package:flutter/material.dart';
import 'package:expenzia/core/routes/app_routes.dart';
import 'package:expenzia/features/home/presentation/pages/home_page.dart';
import 'package:expenzia/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:expenzia/features/splash/presentation/pages/splash_page.dart';
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
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
