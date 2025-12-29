import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/settings_view_model.dart';
import '../../../core/constants/app_dimensions.dart';
import 'widgets/user_profile_card.dart';
import 'widgets/appearance_settings_card.dart';
import 'widgets/notification_settings_card.dart';
import 'widgets/security_settings_card.dart';
import 'widgets/data_management_card.dart';
import '../widgets/language_selector.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsViewModel(),
      child: const _SettingsViewContent(),
    );
  }
}

class _SettingsViewContent extends StatelessWidget {
  const _SettingsViewContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();
    final textTheme = Theme.of(context).textTheme;

    return RefreshIndicator(
      onRefresh: viewModel.refreshData,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Title
            Text(
              'Settings',
              style: textTheme.titleLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage your account settings and preferences',
              style: textTheme.bodySmall,
            ),

            const SizedBox(height: AppDimensions.paddingLarge),

            if (viewModel.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.paddingLarge),
                  child: CircularProgressIndicator(),
                ),
              )
            else ...[
              // User Profile Section
              if (viewModel.userProfile != null)
                UserProfileCard(profile: viewModel.userProfile!),

              const SizedBox(height: AppDimensions.paddingLarge),

              // Appearance Settings
              const AppearanceSettingsCard(),

              const SizedBox(height: AppDimensions.paddingLarge),

              // Language Settings
              const LanguageSelector(),

              const SizedBox(height: AppDimensions.paddingLarge),

              // Notification Settings
              const NotificationSettingsCard(),

              const SizedBox(height: AppDimensions.paddingLarge),

              // Security Settings
              const SecuritySettingsCard(),

              const SizedBox(height: AppDimensions.paddingLarge),

              // Data Management
              const DataManagementCard(),
            ],
          ],
        ),
      ),
    );
  }
}
