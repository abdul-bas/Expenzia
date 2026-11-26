import 'package:flutter/material.dart';

class CreditHeader extends StatelessWidget {
  final bool showBackButton;

  const CreditHeader({
    super.key,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = showBackButton && Navigator.canPop(context);

    return Container(
      width: double.infinity,
      color: const Color(0xFF2F7E79),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 10,
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (canPop)
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 28,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            )
          else
            const SizedBox(width: 28),
          const Text(
            'Credit',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }
}
