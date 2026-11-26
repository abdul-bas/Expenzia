import 'package:flutter/material.dart';

class ProfileInfoSection extends StatelessWidget {
  final String name;
  final VoidCallback onEditName;

  const ProfileInfoSection({
    super.key,
    required this.name,
    required this.onEditName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFF222222),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(
            Icons.border_color,
            size: 18,
            color: Color(0xFF666666),
          ),
          onPressed: onEditName,
          tooltip: 'Edit Name',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
