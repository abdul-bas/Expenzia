import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/features/home/presentation/bloc/home_bloc.dart';
import 'package:expenzia/features/home/presentation/bloc/home_event.dart';
import 'package:expenzia/features/home/presentation/bloc/home_state.dart';
import 'package:expenzia/features/home/presentation/widgets/add_transaction_sheet.dart';
import 'package:expenzia/features/home/presentation/widgets/balance_card.dart';
import 'package:expenzia/features/home/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:expenzia/features/home/presentation/widgets/home_header.dart';
import 'package:expenzia/features/home/presentation/widgets/metrics_row.dart';
import 'package:expenzia/features/home/presentation/widgets/transactions_history_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedNavIndex = 0;

  void _showAddTransactionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return AddTransactionSheet(
          onAdd: (transaction) {
            context.read<HomeBloc>().add(AddTransactionEvent(transaction));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF2F7E79),
                ),
              );
            }

            if (state is HomeError) {
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
                        context.read<HomeBloc>().add(const LoadHomeDataEvent());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final loadedState = state is HomeLoaded
                ? state
                : const HomeLoaded(
                    transactions: [],
                    totalBalance: 2548.00,
                    totalIncome: 1840.00,
                    totalExpense: 284.00,
                    dailyAverage: 1548.00,
                    weekly: 548.00,
                  );

            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: 110,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting & User Name Header
                  HomeHeader(
                    greeting: loadedState.greeting,
                    userName: loadedState.userName,
                  ),

                  const SizedBox(height: 20),

                  // Total Balance & Income/Expenses Card
                  BalanceCard(
                    totalBalance: loadedState.totalBalance,
                    totalIncome: loadedState.totalIncome,
                    totalExpense: loadedState.totalExpense,
                  ),

                  const SizedBox(height: 24),

                  // Daily Average & Weekly Metrics Cards
                  MetricsRow(
                    dailyAverage: loadedState.dailyAverage,
                    weekly: loadedState.weekly,
                  ),

                  const SizedBox(height: 28),

                  // Transactions History List
                  TransactionsHistorySection(
                    transactions: loadedState.transactions,
                    onDeleteTransaction: (id) {
                      context
                          .read<HomeBloc>()
                          .add(DeleteTransactionEvent(id));
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedNavIndex,
        onItemSelected: (index) {
          setState(() => _selectedNavIndex = index);
        },
        onAddPressed: () => _showAddTransactionModal(context),
      ),
    );
  }
}
