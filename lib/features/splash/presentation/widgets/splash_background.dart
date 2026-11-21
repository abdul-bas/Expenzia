import 'package:flutter/material.dart';
import 'package:expenzia/core/constants/app_assets.dart';
import 'package:expenzia/core/constants/app_colors.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Gradient matching Figma (153.16 deg, #63B5AF to #438883)
        Container(
          decoration: const BoxDecoration(
            gradient: AppColors.splashGradient,
          ),
        ),

        // Noise/Texture overlay matching Figma node 1:292 (opacity 10%)
        Opacity(
          opacity: 0.1,
          child: Image.asset(
            AppAssets.splashTexture,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
