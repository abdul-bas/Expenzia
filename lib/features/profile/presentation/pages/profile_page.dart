import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/core/routes/app_routes.dart';
import 'package:expenzia/features/home/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:expenzia/features/profile/domain/entities/profile_entity.dart';
import 'package:expenzia/features/profile/domain/usecases/clear_storage_usecase.dart';
import 'package:expenzia/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:expenzia/features/profile/domain/usecases/update_profile_name_usecase.dart';
import 'package:expenzia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:expenzia/features/profile/presentation/bloc/profile_state.dart';
import 'package:expenzia/features/profile/presentation/controllers/profile_controller.dart';
import 'package:expenzia/features/profile/presentation/widgets/clear_storage_button.dart';
import 'package:expenzia/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:expenzia/features/profile/presentation/widgets/profile_header.dart';
import 'package:expenzia/features/profile/presentation/widgets/profile_info_section.dart';

class ProfilePage extends StatelessWidget {
  final bool showBottomNav;

  const ProfilePage({
    super.key,
    this.showBottomNav = true,
  });

  @override
  Widget build(BuildContext context) {
    final controller = ProfileController(
      getProfileUseCase: context.read<GetProfileUseCase>(),
      updateProfileNameUseCase: context.read<UpdateProfileNameUseCase>(),
      clearStorageUseCase: context.read<ClearStorageUseCase>(),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            // Top Teal Header matching Figma
            const ProfileHeader(),

            // Profile Body Content
            Expanded(
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF2F7E79),
                      ),
                    );
                  }

                  final profile = state is ProfileLoaded
                      ? state.profile
                      : const ProfileLoaded(
                          profile: ProfileEntity(name: 'Sahal Muhammed'),
                        ).profile;

                  return Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),

                          // Profile Avatar
                          ProfileAvatar(
                            avatarPath: profile.avatarPath,
                            onCameraPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Avatar selection coming soon!'),
                                  backgroundColor: Color(0xFF2F7E79),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 20),

                          // User Name & Edit Button
                          ProfileInfoSection(
                            name: profile.name,
                            onEditName: () =>
                                controller.handleEditName(context, profile.name),
                          ),

                          const SizedBox(height: 24),

                          // Clear Storage Pill Button matching Figma 1:588
                          ClearStorageButton(
                            onPressed: () =>
                                controller.handleClearStorage(context),
                          ),

                          const SizedBox(height: 80),
                        ],
                      ),
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
              selectedIndex: 3, // Profile tab active matching Figma 1:578
              onItemSelected: (index) {
                if (index == 0) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                } else if (index == 1) {
                  Navigator.pushReplacementNamed(context, AppRoutes.addExpense);
                } else if (index == 2) {
                  Navigator.pushReplacementNamed(context, AppRoutes.credit);
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
