import 'package:expenzia_app/core/constants/app_string.dart';
import 'package:expenzia_app/core/theme/app_text_styles.dart';

import 'package:expenzia_app/features/splash/presentation/controller/splash_controller.dart';
import 'package:expenzia_app/features/splash/presentation/widgets/splash_baground.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    SplashController.appNavigation(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashBackground(
        child: Center(
          child: Text(AppStrings.appName, style: AppTextStyles.splashTitle),
        ),
      ),
    );
  }
}
