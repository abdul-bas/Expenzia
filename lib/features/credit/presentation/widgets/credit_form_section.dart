import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:expenzia/features/credit/presentation/bloc/credit_bloc.dart';
import 'package:expenzia/features/credit/presentation/bloc/credit_event.dart';
import 'package:expenzia/features/credit/presentation/bloc/credit_state.dart';
import 'package:expenzia/features/credit/presentation/controllers/credit_controller.dart';

class CreditFormSection extends StatelessWidget {
  final TextEditingController toController;
  final TextEditingController amountController;
  final CreditController controller;

  const CreditFormSection({
    super.key,
    required this.toController,
    required this.amountController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditBloc, CreditState>(
      buildWhen: (prev, curr) =>
          prev.creditType != curr.creditType ||
          prev.planType != curr.planType ||
          prev.selectedDate != curr.selectedDate,
      builder: (context, state) {
        final formattedDate =
            DateFormat('EEE, dd MMM yyyy').format(state.selectedDate);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. CREDIT TYPE
            const Text(
              'CREDIT TYPE',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: 0.72,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final selected = await controller.showCreditTypePicker(
                  context,
                  state.creditType,
                );
                if (selected != null && context.mounted) {
                  context
                      .read<CreditBloc>()
                      .add(ChangeCreditTypeEvent(selected));
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFDDDDDD)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.creditType,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.14,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF666666),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // 2. TO
            const Text(
              'TO',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: 0.72,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFDDDDDD)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: TextField(
                controller: toController,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: -0.14,
                  color: Color(0xFF222222),
                ),
                decoration: const InputDecoration(
                  hintText: 'Netflix',
                  hintStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: -0.14,
                    color: Color(0xFF666666),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // 3. AMOUNT
            const Text(
              'AMOUNT',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: 0.72,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF438883),
                  width: 1.4,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text(
                    '\$ ',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      letterSpacing: -0.14,
                      color: Color(0xFF438883),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        letterSpacing: -0.14,
                        color: Color(0xFF438883),
                      ),
                      decoration: const InputDecoration(
                        hintText: '850.00',
                        hintStyle: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: -0.14,
                          color: Color(0x99438883),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => amountController.clear(),
                    child: const Text(
                      'Clear',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF438883),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 4. DATE
            const Text(
              'DATE',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: 0.72,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final picked = await controller.pickDate(
                  context,
                  state.selectedDate,
                );
                if (picked != null && context.mounted) {
                  context
                      .read<CreditBloc>()
                      .add(ChangeCreditDateEvent(picked));
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFDDDDDD)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.14,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: Color(0xFF666666),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // 5. PLAN TYPE
            const Text(
              'PLAN TYPE',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: 0.72,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final selected = await controller.showPlanTypePicker(
                  context,
                  state.planType,
                );
                if (selected != null && context.mounted) {
                  context
                      .read<CreditBloc>()
                      .add(ChangePlanTypeEvent(selected));
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFDDDDDD)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.planType,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.14,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF666666),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
