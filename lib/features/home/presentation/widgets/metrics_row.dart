import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MetricsRow extends StatelessWidget {
  final double dailyAverage;
  final double weekly;

  const MetricsRow({
    super.key,
    required this.dailyAverage,
    required this.weekly,
  });

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return '\$ ${formatter.format(amount)}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Daily Average Card
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DAILY AVERAGE',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF666666),
                  letterSpacing: 0.72,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 69,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.5),
                  border: Border.all(
                    color: const Color(0xFFDDDDDD),
                    width: 1.3,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  _formatAmount(dailyAverage),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF050505),
                    letterSpacing: -1.0,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // Weekly Card
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'WEEKLY',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF666666),
                  letterSpacing: 0.72,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 69,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.5),
                  border: Border.all(
                    color: const Color(0xFFDDDDDD),
                    width: 1.3,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  _formatAmount(weekly),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF050505),
                    letterSpacing: -1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
