import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final VoidCallback onAddPressed;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          // Teal bottom bar container
          Container(
            height: 70,
            decoration: const BoxDecoration(
              color: Color(0xFF2F7E79),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Home
                IconButton(
                  icon: Icon(
                    selectedIndex == 0
                        ? Icons.home_rounded
                        : Icons.home_outlined,
                    color: selectedIndex == 0 ? Colors.white : Colors.white60,
                    size: 28,
                  ),
                  onPressed: () => onItemSelected(0),
                ),

                // History
                IconButton(
                  icon: Icon(
                    Icons.history_rounded,
                    color: selectedIndex == 1 ? Colors.white : Colors.white60,
                    size: 28,
                  ),
                  onPressed: () => onItemSelected(1),
                ),

                // Center gap for floating action button
                const SizedBox(width: 48),

                // Wallet
                IconButton(
                  icon: Icon(
                    Icons.account_balance_wallet_outlined,
                    color: selectedIndex == 2 ? Colors.white : Colors.white60,
                    size: 26,
                  ),
                  onPressed: () => onItemSelected(2),
                ),

                // Profile
                IconButton(
                  icon: Icon(
                    Icons.person_outline_rounded,
                    color: selectedIndex == 3 ? Colors.white : Colors.white60,
                    size: 28,
                  ),
                  onPressed: () => onItemSelected(3),
                ),
              ],
            ),
          ),

          // Elevated Center '+' Button matching Figma
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: onAddPressed,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF3E8681),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2F7E79).withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
