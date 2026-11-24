import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:expenzia/features/transaction/presentation/bloc/transaction_state.dart';

class TransactionSaveButton extends StatelessWidget {
  final VoidCallback onSave;

  const TransactionSaveButton({
    super.key,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      buildWhen: (prev, curr) => prev.isSubmitting != curr.isSubmitting,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: state.isSubmitting ? null : onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F7E79),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: state.isSubmitting
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : const Text(
                    'Save',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: -0.36,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
