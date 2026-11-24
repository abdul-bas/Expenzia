import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/core/routes/app_routes.dart';
import 'package:expenzia/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:expenzia/features/expense/presentation/bloc/expense_event.dart';
import 'package:expenzia/features/expense/presentation/bloc/expense_state.dart';
import 'package:expenzia/features/expense/presentation/controllers/expense_controller.dart';
import 'package:expenzia/features/expense/presentation/widgets/expense_empty_view.dart';
import 'package:expenzia/features/expense/presentation/widgets/expense_header.dart';
import 'package:expenzia/features/expense/presentation/widgets/expense_list_item.dart';
import 'package:expenzia/features/home/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:expenzia/features/transaction/domain/usecases/delete_transaction_usecase.dart';
import 'package:expenzia/features/transaction/domain/usecases/get_transactions_usecase.dart';

class AddExpensePage extends StatelessWidget {
  final bool showBottomNav;

  const AddExpensePage({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    final controller = ExpenseController(
      getTransactionsUseCase: context.read<GetTransactionsUseCase>(),
      deleteTransactionUseCase: context.read<DeleteTransactionUseCase>(),
    );

    return Scaffold(

      appBar: AppBar(
        flexibleSpace:     const ExpenseHeader(),),
      backgroundColor: Colors.white,
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2F7E79)),
            );
          }
      
          if (state is ExpenseError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ExpenseBloc>().add(
                        const LoadExpenseTransactionsEvent(),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
      
          if (state is ExpenseLoaded) {
            if (state.transactions.isEmpty) {
              return const ExpenseEmptyView();
            }
      
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                final tx = state.transactions[index];
                return ExpenseListItem(
                  transaction: tx,
                  controller: controller,
                );
              },
            );
          }
      
          return const ExpenseEmptyView();
        },
      ),
      bottomNavigationBar: showBottomNav
          ? CustomBottomNavBar(
              selectedIndex: 1, // History tab selected as in Figma 1:386
              onItemSelected: (index) {
                if (index == 0) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                } else if (index == 2) {
                  Navigator.pushReplacementNamed(context, AppRoutes.credit);
                }
              },
              onAddPressed: () => controller.navigateToAdd(context),
            )
          : null,
    );
  }
}
