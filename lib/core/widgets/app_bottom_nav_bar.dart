import 'package:expenzia_app/core/constants/app_alignments.dart';
import 'package:expenzia_app/core/constants/app_colors.dart';
import 'package:expenzia_app/core/constants/app_icons.dart';
import 'package:flutter/material.dart';


class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    this.currentIndex = 0,
    this.onItemSelected,
    this.onAddPressed,
  });

  final int currentIndex;
  final ValueChanged<int>? onItemSelected;
  final VoidCallback? onAddPressed;

  

  
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      width: double.infinity,
      child: Stack(
        children: [
       
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 80,
            child: ColoredBox(color: AppColors.green),
          ),

        
          Align(
            alignment: const Alignment(0, -0.297),
            child: Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),

      
          Align(
            alignment: const Alignment(0, -0.297),
            child: GestureDetector(
              onTap: onAddPressed,
              child: Container(
                width: 78,
                height: 78,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  size: 37.5,
                  color: AppColors.white,
                ),
              ),
            ),
          ),

          // Icons
          for (var i = 0; i < AppIcons.appNavIcons.length; i++)
            Align(
              alignment: Alignment(AppAlignments.navXPositions[i], 0.4375),
              child: GestureDetector(
                onTap: () => onItemSelected?.call(i),
                child: Icon(
                  AppIcons.appNavIcons[i],
                  size: 30,
                  color: i == currentIndex
                      ? AppColors.white
                      : AppColors.navInactive,
                ),
              ),
            ),
        ],
      ),
    );
  }
}