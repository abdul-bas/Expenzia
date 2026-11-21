import 'package:flutter/material.dart';
import 'package:expenzia/core/constants/app_strings.dart';
import 'package:expenzia/core/routes/app_router.dart';
import 'package:expenzia/core/routes/app_routes.dart';
import 'package:expenzia/core/theme/app_theme.dart';
import 'package:expenzia/features/splash/presentation/pages/splash_page.dart';

void main() {
  runApp(const ExpenziaApp());
}

class ExpenziaApp extends StatelessWidget {
  const ExpenziaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: SplashPage(),
    );
  }
}
