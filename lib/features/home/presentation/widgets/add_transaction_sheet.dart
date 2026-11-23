import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenzia/core/constants/app_colors.dart';
import 'package:expenzia/domain/entities/transaction_entity.dart';

class AddTransactionSheet extends StatefulWidget {
  final Function(TransactionEntity transaction) onAdd;

  const AddTransactionSheet({super.key, required this.onAdd});

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController(text: 'General');

  bool _isIncome = true;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
      final now = DateTime.now();
      final formattedDate = DateFormat('MMM dd, yyyy').format(now);

      final transaction = TransactionEntity(
        title: _titleController.text.trim(),
        amount: amount,
        isIncome: _isIncome,
        category: _categoryController.text.trim().isEmpty
            ? 'General'
            : _categoryController.text.trim(),
        date: formattedDate,
        createdAt: now,
      );

      widget.onAdd(transaction);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Add Transaction',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF222222),
                ),
              ),
              const SizedBox(height: 18),

              // Income / Expense Toggle
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Income')),
                      selected: _isIncome,
                      selectedColor: const Color(0xFF2F7E79),
                      labelStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        color: _isIncome ? Colors.white : Colors.black87,
                      ),
                      onSelected: (val) {
                        setState(() => _isIncome = true);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Expense')),
                      selected: !_isIncome,
                      selectedColor: const Color(0xFFF95B51),
                      labelStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        color: !_isIncome ? Colors.white : Colors.black87,
                      ),
                      onSelected: (val) {
                        setState(() => _isIncome = false);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Title input
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'e.g. Upwork, Coffee, Salary',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Enter title' : null,
              ),
              const SizedBox(height: 14),

              // Amount input
              TextFormField(
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Amount (\$)',
                  hintText: '0.00',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Enter amount';
                  }
                  final parsed = double.tryParse(val.trim());
                  if (parsed == null || parsed <= 0) {
                    return 'Enter a valid positive number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Category input
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Category',
                  hintText: 'e.g. Work, Food, Shopping',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    gradient: AppColors.buttonGradient,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(26),
                      onTap: _submit,
                      child: const Center(
                        child: Text(
                          'Save Transaction',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
