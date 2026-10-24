import 'package:expenzia_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';


class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.077, -0.982),
          end: Alignment(1.077, 0.982),
          colors: [
            AppColors.splashGradientStart,
            AppColors.splashGradientEnd,
          ],
          stops: [0.0448, 1.0],
        ),
      ),
      child: child,
    );
  }
}