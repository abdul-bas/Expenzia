import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String greeting;
  final String userName;

  const HomeHeader({
    super.key,
    required this.greeting,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF050505),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          userName,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF050505),
          ),
        ),
      ],
    );
  }
}
