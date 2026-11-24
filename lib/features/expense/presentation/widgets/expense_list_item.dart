import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';

class ExpenseListItem extends StatelessWidget {
  final TransactionEntity transaction;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  const ExpenseListItem({
    super.key,
    required this.transaction,
    required this.onDelete,
    this.onEdit,
  });

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.isIncome;
    final amountSign = isIncome ? '+ ' : '- ';
    final amountColor =
        isIncome ? const Color(0xFF25A969) : const Color(0xFFF95B51);

    return Dismissible(
      key: Key('transaction_${transaction.id ?? transaction.createdAt.toIso8601String()}'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: const Color(0xFFFB3E3E),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 22,
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Delete Transaction'),
            content: Text('Are you sure you want to delete "${transaction.title}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => onDelete(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFF4F4F4),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Title & Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: -0.32,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    transaction.date,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      letterSpacing: -0.26,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),

            // Amount
            Text(
              '$amountSign\$ ${_formatAmount(transaction.amount)}',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: -0.72,
                color: amountColor,
              ),
            ),

            const SizedBox(width: 8),

            // Delete action button
            IconButton(
              icon: const Icon(
                Icons.border_color,
                size: 20,
                color: Color(0xFF999999),
              ),
              onPressed: () {
                
              },
            ),
          ],
        ),
      ),
    );
  }
}
