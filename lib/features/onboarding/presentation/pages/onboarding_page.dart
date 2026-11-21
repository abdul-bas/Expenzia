import 'package:flutter/material.dart';
import 'package:expenzia/core/constants/app_colors.dart';
import 'package:expenzia/core/constants/app_strings.dart';
import 'package:expenzia/core/routes/app_routes.dart';
import 'package:expenzia/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:expenzia/features/onboarding/presentation/widgets/onboarding_button.dart';
import 'package:expenzia/features/onboarding/presentation/widgets/onboarding_hero.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({
    super.key,
    OnboardingController? controller,
  }) : controller = controller ?? OnboardingController();

  final OnboardingController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: true,
        child: Column(
          children: [
            // 3D Illustration hero with curved background & concentric ripples
            const OnboardingHero(),

            const Spacer(),

            // Title: "Spend Smarter\nSave More"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                AppStrings.spendSmarterSaveMore,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 36,
                  height: 38 / 36,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onboardingTitle,
                  letterSpacing: -0.72,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // "Get Started" Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: OnboardingButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
