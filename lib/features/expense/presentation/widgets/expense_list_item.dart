import 'package:flutter/material.dart';
import 'package:expenzia/features/expense/presentation/controllers/expense_controller.dart';
import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';

class ExpenseListItem extends StatelessWidget {
  final TransactionEntity transaction;
  final ExpenseController controller;

  const ExpenseListItem({
    super.key,
    required this.transaction,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.isIncome;
    final amountSign = isIncome ? '+ ' : '- ';
    final amountColor =
        isIncome ? const Color(0xFF25A969) : const Color(0xFFF95B51);

    return Dismissible(
      key: Key('tx_${transaction.id ?? transaction.createdAt.toIso8601String()}'),
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
      confirmDismiss: (_) => controller.confirmDelete(context, transaction),
      onDismissed: (_) {
        if (transaction.id != null) {
          controller.deleteTransaction(transaction.id!);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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

            // Formatted Amount
            Text(
              '$amountSign\$ ${controller.formatAmount(transaction.amount)}',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: -0.72,
                color: amountColor,
              ),
            ),

            const SizedBox(width: 8),

            // Edit icon button with Icons.border_color matching user requirement
            IconButton(
              icon: const Icon(
                Icons.border_color,
                size: 20,
                color: Color(0xFF666666),
              ),
              onPressed: () => controller.navigateToEdit(context, transaction),
              tooltip: 'Edit Transaction',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),

            const SizedBox(width: 8),

            // Delete icon button
           
          ],
        ),
      ),
    );
  }
}
