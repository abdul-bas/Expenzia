import 'package:flutter/material.dart';
import 'package:expenzia/core/routes/app_routes.dart';
import 'package:expenzia/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashPage());
      default:
        return MaterialPageRoute(builder: (_) => SplashPage());
    }
  }
}
