import 'package:flutter/material.dart';
import 'package:expenzia/core/constants/app_strings.dart';

class SplashTitle extends StatelessWidget {
  const SplashTitle({
    super.key,
    this.opacity = 1.0,
  });

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
        opacity: opacity,
        child: const Text(
          AppStrings.splashTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 50,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -2.0,
          ),
        ),
      ),
    );
  }
}
