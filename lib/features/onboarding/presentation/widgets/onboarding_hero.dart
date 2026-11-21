import 'package:flutter/material.dart';
import 'package:expenzia/core/constants/app_assets.dart';

class OnboardingHero extends StatelessWidget {
  const OnboardingHero({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final heroHeight = mediaQuery.size.height * 0.62;

    return SizedBox(
      height: heroHeight,
      width: double.infinity,
      child: Image.asset(
        AppAssets.onboardingHero,
        fit: BoxFit.contain,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
