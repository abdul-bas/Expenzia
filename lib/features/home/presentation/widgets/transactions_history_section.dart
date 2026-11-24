import 'package:flutter/material.dart';
import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';
import 'package:expenzia/features/home/presentation/widgets/transaction_item_widget.dart';

class TransactionsHistorySection extends StatelessWidget {
  final List<TransactionEntity> transactions;
  final Function(int id)? onDeleteTransaction;

  const TransactionsHistorySection({
    super.key,
    required this.transactions,
    this.onDeleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Transactions history',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF222222),
                letterSpacing: -0.36,
              ),
            ),
            Text(
              'See all',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(0xFF666666),
                letterSpacing: -0.28,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (transactions.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Center(
              child: Text(
                'No transactions recorded yet',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF666666),
                ),
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            separatorBuilder: (_, _) => const Divider(
              color: Color(0xFFF0F0F0),
              height: 1,
            ),
            itemBuilder: (context, index) {
              final tx = transactions[index];
              return TransactionItemWidget(
                transaction: tx,
                onDelete: tx.id != null
                    ? () => onDeleteTransaction?.call(tx.id!)
                    : null,
              );
            },
          ),
      ],
    );
  }
}
