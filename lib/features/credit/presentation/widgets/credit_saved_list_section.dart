import 'package:flutter/material.dart';
import 'package:expenzia/features/credit/domain/entities/credit_entity.dart';
import 'package:expenzia/features/credit/presentation/controllers/credit_controller.dart';

class CreditSavedListSection extends StatelessWidget {
  final List<CreditEntity> credits;
  final CreditController controller;

  const CreditSavedListSection({
    super.key,
    required this.credits,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (credits.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Saved Lists',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: -0.32,
            color: Color(0xFF222222),
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: credits.length,
          separatorBuilder: (_, _) => const Divider(
            color: Color(0xFFEEEEEE),
            height: 1,
          ),
          itemBuilder: (context, index) {
            final item = credits[index];
            final isDueToday = item.dueDate.toLowerCase().contains('today');

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  // Left: To / Name & Due status
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.toName,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: -0.32,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (isDueToday)
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                letterSpacing: -0.26,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Due',
                                  style: TextStyle(color: Color(0xFF666666)),
                                ),
                                TextSpan(
                                  text: ' Today',
                                  style: TextStyle(
                                    color: Color(0xFFD22E2E),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Text(
                            item.dueDate,
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

                  // Right: Plan Type & Amount
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.planType,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          letterSpacing: -0.26,
                          color: Color(0xFF666666),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$ ${controller.formatAmount(item.amount)}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          letterSpacing: -0.72,
                          color: Color(0xFF272727),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 8),

                  // Delete action
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 20,
                      color: Color(0xFF999999),
                    ),
                    onPressed: () => controller.confirmAndDelete(context, item),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
