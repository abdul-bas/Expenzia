import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BalanceCard extends StatelessWidget {
  final double totalBalance;
  final double totalIncome;
  final double totalExpense;

  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpense,
  });

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return '\$ ${formatter.format(amount)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF2F7E79),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B5C58).withOpacity(0.45),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Balance',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: -0.32,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _formatAmount(totalBalance),
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -1.5,
            ),
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Income
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_downward_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Income',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFD0E5E4),
                          letterSpacing: -0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatAmount(totalIncome),
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: -1.0,
                    ),
                  ),
                ],
              ),

              // Expenses
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_upward_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Expenses',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFD0E5E4),
                          letterSpacing: -0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatAmount(totalExpense),
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: -1.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
