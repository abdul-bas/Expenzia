import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenzia/features/home/domain/entities/transaction_entity.dart';

class TransactionItemWidget extends StatelessWidget {
  final TransactionEntity transaction;
  final VoidCallback? onDelete;

  const TransactionItemWidget({
    super.key,
    required this.transaction,
    this.onDelete,
  });

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return '\$ ${formatter.format(amount)}';
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.isIncome;
    final amountPrefix = isIncome ? '+ ' : '- ';
    final amountColor =
        isIncome ? const Color(0xFF25A969) : const Color(0xFFF95B51);

    return Dismissible(
      key: ValueKey(transaction.id ?? transaction.createdAt.toIso8601String()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF95B51),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      onDismissed: (_) => onDelete?.call(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: -0.32,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.date,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF666666),
                    letterSpacing: -0.26,
                  ),
                ),
              ],
            ),
            Text(
              '$amountPrefix${_formatAmount(transaction.amount)}',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: amountColor,
                letterSpacing: -0.72,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
