import 'package:flutter/material.dart';

class ClearStorageButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ClearStorageButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 38,
        width: 134,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: const Color(0xFFDEDEDE)),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Clear Storage',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.normal,
            fontSize: 15,
            color: Color(0xFFAEAEAE),
          ),
        ),
      ),
    );
  }
}
