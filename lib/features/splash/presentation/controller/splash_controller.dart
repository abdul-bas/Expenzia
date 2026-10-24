import 'package:expenzia_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';

class SplashController {
 static void appNavigation(BuildContext context)async{
  
  await  Future.delayed(Duration(seconds: 3));
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OnboardingPage()),
    );
}
}