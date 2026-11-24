import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/core/routes/app_routes.dart';
import 'package:expenzia/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:expenzia/features/expense/presentation/bloc/expense_event.dart';
import 'package:expenzia/features/expense/presentation/bloc/expense_state.dart';
import 'package:expenzia/features/expense/presentation/widgets/expense_empty_view.dart';
import 'package:expenzia/features/expense/presentation/widgets/expense_header.dart';
import 'package:expenzia/features/expense/presentation/widgets/expense_list_item.dart';
import 'package:expenzia/features/home/presentation/widgets/custom_bottom_nav_bar.dart';

class AddExpensePage extends StatelessWidget {
  final bool showBottomNav;

  const AddExpensePage({
    super.key,
    this.showBottomNav = true,
  });

  Future<void> _navigateToAddTransaction(BuildContext context) async {
    final result = await Navigator.pushNamed(context, AppRoutes.transaction);
    if (result == true && context.mounted) {
      context.read<ExpenseBloc>().add(const LoadExpenseTransactionsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            // Top Teal Header matching Figma
            const ExpenseHeader(),

            // Transactions List from SQLite via BLoC
            Expanded(
              child: BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
                  if (state is ExpenseLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF2F7E79),
                      ),
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
                              context
                                  .read<ExpenseBloc>()
                                  .add(const LoadExpenseTransactionsEvent());
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
                          onDelete: () {
                            if (tx.id != null) {
                              context
                                  .read<ExpenseBloc>()
                                  .add(DeleteExpenseTransactionEvent(tx.id!));
                            }
                          },
                        );
                      },
                    );
                  }

                  return const ExpenseEmptyView();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: showBottomNav
          ? CustomBottomNavBar(
              selectedIndex: 1, // History tab selected as in Figma 1:386
              onItemSelected: (index) {
                if (index == 0) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                }
              },
              onAddPressed: () => _navigateToAddTransaction(context),
            )
          : null,
    );
  }
}
