import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:expenzia/features/transaction/presentation/bloc/edit_transaction_bloc.dart';
import 'package:expenzia/features/transaction/presentation/bloc/edit_transaction_event.dart';
import 'package:expenzia/features/transaction/presentation/bloc/edit_transaction_state.dart';
import 'package:expenzia/features/transaction/presentation/controllers/edit_transaction_controller.dart';

class EditTransactionCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController amountController;
  final EditTransactionController controller;

  const EditTransactionCard({
    super.key,
    required this.nameController,
    required this.amountController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionBloc, EditTransactionState>(
      buildWhen: (prev, curr) =>
          prev.isIncome != curr.isIncome ||
          prev.selectedDate != curr.selectedDate,
      builder: (context, state) {
        final formattedDate =
            DateFormat('EEE, dd MMM yyyy').format(state.selectedDate);

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                blurRadius: 35,
                spreadRadius: 0,
                offset: Offset(0, 0),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. TRANSACTION TYPE
              const Text(
                'TRANSACTION TYPE',
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
                  final isIncome = await controller.showTypePicker(
                    context,
                    state.isIncome,
                  );
                  if (isIncome != null && context.mounted) {
                    context
                        .read<EditTransactionBloc>()
                        .add(ChangeEditTypeEvent(isIncome));
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
                        state.isIncome ? 'Income' : 'Expense',
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

              const SizedBox(height: 20),

              // 2. NAME
              const Text(
                'NAME',
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
                  controller: nameController,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: -0.14,
                    color: Color(0xFF222222),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'e.g. Upwork',
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

              const SizedBox(height: 20),

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
                          hintText: '0.00',
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

              const SizedBox(height: 20),

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
                        .read<EditTransactionBloc>()
                        .add(ChangeEditDateEvent(picked));
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
            ],
          ),
        );
      },
    );
  }
}
