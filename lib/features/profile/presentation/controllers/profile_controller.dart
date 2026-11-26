import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/features/credit/presentation/bloc/credit_bloc.dart';
import 'package:expenzia/features/credit/presentation/bloc/credit_event.dart';
import 'package:expenzia/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:expenzia/features/expense/presentation/bloc/expense_event.dart';
import 'package:expenzia/features/home/presentation/bloc/home_bloc.dart';
import 'package:expenzia/features/home/presentation/bloc/home_event.dart';
import 'package:expenzia/features/profile/domain/entities/profile_entity.dart';
import 'package:expenzia/features/profile/domain/usecases/clear_storage_usecase.dart';
import 'package:expenzia/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:expenzia/features/profile/domain/usecases/update_profile_name_usecase.dart';
import 'package:expenzia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:expenzia/features/profile/presentation/bloc/profile_event.dart';

class ProfileController {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileNameUseCase updateProfileNameUseCase;
  final ClearStorageUseCase clearStorageUseCase;

  ProfileController({
    required this.getProfileUseCase,
    required this.updateProfileNameUseCase,
    required this.clearStorageUseCase,
  });

  /// Loads profile from SQLite database
  Future<ProfileEntity> loadProfile() async {
    return await getProfileUseCase();
  }

  /// Updates profile name in SQLite database
  Future<void> updateProfileName(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw Exception('Name cannot be empty');
    }
    await updateProfileNameUseCase(trimmed);
  }

  /// Clears SQLite database tables
  Future<void> clearAllStorage() async {
    await clearStorageUseCase();
  }

  /// Opens a dialog to edit the user's name
  Future<String?> showEditNameDialog(
    BuildContext context,
    String currentName,
  ) async {
    final textController = TextEditingController(text: currentName);

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          'Edit Profile Name',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        content: TextField(
          controller: textController,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = textController.text.trim();
              if (newName.isNotEmpty) {
                Navigator.pop(dialogContext, newName);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F7E79),
            ),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    return result;
  }

  /// Handles user name edit flow and triggers BLoC update
  Future<void> handleEditName(
    BuildContext context,
    String currentName,
  ) async {
    final newName = await showEditNameDialog(context, currentName);
    if (newName != null && context.mounted) {
      context.read<ProfileBloc>().add(UpdateProfileNameEvent(newName));
    }
  }

  /// Shows confirmation alert dialog before wiping storage
  Future<bool> confirmClearStorage(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          'Clear Storage',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        content: const Text(
          'Are you sure you want to clear all storage data? This will reset all transactions, credits, and profile data.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    return confirmed ?? false;
  }

  /// Handles storage wipe with confirmation and refreshes all relevant BLoCs
  Future<void> handleClearStorage(BuildContext context) async {
    final confirmed = await confirmClearStorage(context);
    if (confirmed && context.mounted) {
      context.read<ProfileBloc>().add(const ClearStorageEvent());
      // Refresh home, expense, and credit states across the application
      context.read<HomeBloc>().add(const LoadHomeDataEvent());
      context.read<ExpenseBloc>().add(const LoadExpenseTransactionsEvent());
      context.read<CreditBloc>().add(const LoadCreditsEvent());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage cleared successfully!'),
          backgroundColor: Color(0xFF2F7E79),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
