import 'package:expenzia_app/core/constants/app_assets.dart';
import 'package:expenzia_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';


class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
        
          Center(
            child: SizedBox(
              width: 350,
              height: 600,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: -84,
                    top: 126.9,
                    width: 524.14,
                    height: 486.09,
                    child: Image.asset(AppAssets.man, fit: BoxFit.fill),
                  ),
                  Positioned(
                    left: 81.3,
                    top: 131.6,
                    width: 95.57,
                    height: 95.57,
                    child: Image.asset(AppAssets.coin, fit: BoxFit.fill),
                  ),
                  Positioned(
                    left: 268.36,
                    top: 205.84,
                    width: 88.47,
                    height: 88.47,
                    child: Image.asset(AppAssets.donut, fit: BoxFit.fill),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
