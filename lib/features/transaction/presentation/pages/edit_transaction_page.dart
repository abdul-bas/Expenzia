import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';
import 'package:expenzia/features/transaction/domain/usecases/update_transaction_usecase.dart';
import 'package:expenzia/features/transaction/presentation/bloc/edit_transaction_bloc.dart';
import 'package:expenzia/features/transaction/presentation/bloc/edit_transaction_event.dart';
import 'package:expenzia/features/transaction/presentation/bloc/edit_transaction_state.dart';
import 'package:expenzia/features/transaction/presentation/controllers/edit_transaction_controller.dart';
import 'package:expenzia/features/transaction/presentation/widgets/edit_transaction_card.dart';
import 'package:expenzia/features/transaction/presentation/widgets/edit_transaction_header.dart';
import 'package:expenzia/features/transaction/presentation/widgets/edit_transaction_save_button.dart';

class EditTransactionPage extends StatelessWidget {
  final TransactionEntity transaction;
  final TextEditingController _nameController;
  final TextEditingController _amountController;

  EditTransactionPage({
    super.key,
    required this.transaction,
  })  : _nameController = TextEditingController(text: transaction.title),
        _amountController = TextEditingController(
          text: transaction.amount.toStringAsFixed(2),
        );

  @override
  Widget build(BuildContext context) {
    final updateUseCase = context.read<UpdateTransactionUseCase>();
    final controller = EditTransactionController(
      updateTransactionUseCase: updateUseCase,
    );

    return BlocProvider<EditTransactionBloc>(
      create: (_) => EditTransactionBloc(
        updateTransactionUseCase: updateUseCase,
        initialTransaction: transaction,
      ),
      child: BlocConsumer<EditTransactionBloc, EditTransactionState>(
        listenWhen: (prev, curr) =>
            curr.isSuccess || curr.errorMessage != null,
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
                content: Text('Transaction updated successfully!'),
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
                flexibleSpace: EditTransactionHeader(
                    onBack: () => Navigator.pop(context),
                  ),),
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
                        
                  // Form Card
                  EditTransactionCard(
                    nameController: _nameController,
                    amountController: _amountController,
                    controller: controller,
                  ),
                        
                  const SizedBox(height: 36),
                        
                  // Pill Save Button
                  EditTransactionSaveButton(
                    onSave: () {
                      if (transaction.id != null) {
                        context.read<EditTransactionBloc>().add(
                              SubmitEditTransactionEvent(
                                id: transaction.id!,
                                title: _nameController.text,
                                amountString: _amountController.text,
                                category: transaction.category,
                              ),
                            );
                      }
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
