import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/core/routes/app_routes.dart';
import 'package:expenzia/features/credit/domain/usecases/add_credit_usecase.dart';
import 'package:expenzia/features/credit/domain/usecases/delete_credit_usecase.dart';
import 'package:expenzia/features/credit/domain/usecases/get_credits_usecase.dart';
import 'package:expenzia/features/credit/presentation/bloc/credit_bloc.dart';
import 'package:expenzia/features/credit/presentation/bloc/credit_event.dart';
import 'package:expenzia/features/credit/presentation/bloc/credit_state.dart';
import 'package:expenzia/features/credit/presentation/controllers/credit_controller.dart';
import 'package:expenzia/features/credit/presentation/widgets/credit_form_section.dart';
import 'package:expenzia/features/credit/presentation/widgets/credit_header.dart';
import 'package:expenzia/features/credit/presentation/widgets/credit_save_button.dart';
import 'package:expenzia/features/credit/presentation/widgets/credit_saved_list_section.dart';
import 'package:expenzia/features/home/presentation/widgets/custom_bottom_nav_bar.dart';

class CreditPage extends StatelessWidget {
  final bool showBottomNav;
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  CreditPage({
    super.key,
    this.showBottomNav = true,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CreditController(
      getCreditsUseCase: context.read<GetCreditsUseCase>(),
      addCreditUseCase: context.read<AddCreditUseCase>(),
      deleteCreditUseCase: context.read<DeleteCreditUseCase>(),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            // Top Teal Header matching Figma
            const CreditHeader(),

            // Content ScrollView with Form & Saved Lists
            Expanded(
              child: BlocConsumer<CreditBloc, CreditState>(
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
                        content: Text('Credit entry saved successfully!'),
                        backgroundColor: Color(0xFF2F7E79),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    _toController.clear();
                    _amountController.clear();
                  }
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 20,
                      bottom: 110,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Form Input Section
                        CreditFormSection(
                          toController: _toController,
                          amountController: _amountController,
                          controller: controller,
                        ),

                        const SizedBox(height: 24),

                        // Pill Save Button
                        CreditSaveButton(
                          onSave: () {
                            context.read<CreditBloc>().add(
                                  SubmitCreditEvent(
                                    toName: _toController.text,
                                    amountString: _amountController.text,
                                  ),
                                );
                          },
                        ),

                        const SizedBox(height: 36),

                        // "Your Saved Lists" Section
                        CreditSavedListSection(
                          credits: state.credits,
                          controller: controller,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: showBottomNav
          ? CustomBottomNavBar(
              selectedIndex: 2, // Wallet / Credit tab active matching Figma 1:476
              onItemSelected: (index) {
                if (index == 0) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                } else if (index == 1) {
                  Navigator.pushReplacementNamed(context, AppRoutes.addExpense);
                }
              },
              onAddPressed: () {
                Navigator.pushNamed(context, AppRoutes.transaction);
              },
            )
          : null,
    );
  }
}
