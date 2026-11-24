import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/features/transaction/domain/usecases/add_transaction_usecase.dart';
import 'package:expenzia/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:expenzia/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:expenzia/features/transaction/presentation/bloc/transaction_state.dart';
import 'package:expenzia/features/transaction/presentation/widgets/transaction_card.dart';
import 'package:expenzia/features/transaction/presentation/widgets/transaction_header.dart';
import 'package:expenzia/features/transaction/presentation/widgets/transaction_save_button.dart';

class TransactionPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addUseCase = context.read<AddTransactionUseCase>();

    return BlocProvider<TransactionBloc>(
      create: (_) => TransactionBloc(addTransactionUseCase: addUseCase),
      child: BlocConsumer<TransactionBloc, TransactionState>(
        listenWhen: (prev, curr) => curr.isSuccess || curr.errorMessage != null,
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red[700],
              ),
            );
          } else if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Transaction saved successfully!'),
                backgroundColor: Color(0xFF2F7E79),
                duration: Duration(seconds: 1),
              ),
            );
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBar(automaticallyImplyLeading: false,
                flexibleSpace: TransactionHeader(
                  onBack: () => Navigator.pop(context),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 30,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
            
                  // Form Card matching Figma
                  TransactionCard(
                    nameController: _nameController,
                    amountController: _amountController,
                  ),
            
                  const SizedBox(height: 36),
            
                  // Pill Save Button matching Figma
                  TransactionSaveButton(
                    onSave: () {
                      context.read<TransactionBloc>().add(
                        SubmitTransactionEvent(
                          title: _nameController.text,
                          amountString: _amountController.text,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
