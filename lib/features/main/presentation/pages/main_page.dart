import 'package:expenzia_app/core/widgets/app_bottom_nav_bar.dart';
import 'package:expenzia_app/features/transaction/presentation/pages/transaction_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: AppBottomNavBar(onAddPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionPage(),)),));
  }
}
