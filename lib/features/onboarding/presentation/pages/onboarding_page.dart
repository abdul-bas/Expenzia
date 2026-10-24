import 'package:expenzia_app/core/constants/app_colors.dart';
import 'package:expenzia_app/core/constants/app_string.dart';
import 'package:expenzia_app/core/theme/app_text_styles.dart';
import 'package:expenzia_app/features/main/presentation/pages/main_page.dart';
import 'package:expenzia_app/features/onboarding/presentation/widgets/get_started_button.dart';
import 'package:expenzia_app/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OnboardingHeader(),
            const SizedBox(height: 43),
            SizedBox(
              width: 300,
              child: Text(
                AppStrings.onboardingTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.onboardingTitle,
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: GetStartedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
