import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/settings_view_model.dart';
import '../../../../core/constants/app_dimensions.dart';

class DataManagementCard extends StatelessWidget {
  const DataManagementCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.storage_outlined,
                  size: 24,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data Management',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Manage your data and application storage',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingMedium),
            const Divider(height: 1),
            const SizedBox(height: AppDimensions.paddingMedium),

            // Export Data
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: viewModel.isLoading
                    ? null
                    : () async {
                        await viewModel.exportData();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Data exported successfully'),
                            ),
                          );
                        }
                      },
                icon: const Icon(Icons.file_download_outlined, size: 20),
                label: const Text('Export All Data'),
              ),
            ),

            const SizedBox(height: 12),

            // Clear Cache
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: viewModel.isLoading
                    ? null
                    : () async {
                        await viewModel.clearCache();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cache cleared successfully'),
                            ),
                          );
                        }
                      },
                icon: const Icon(Icons.delete_sweep_outlined, size: 20),
                label: const Text('Clear Cache'),
              ),
            ),

            const SizedBox(height: AppDimensions.paddingMedium),
            const Divider(height: 1),
            const SizedBox(height: AppDimensions.paddingMedium),

            // Danger Zone
            Text(
              'Danger Zone',
              style: textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.error,
              ),
            ),
            const SizedBox(height: 12),

            // Reset Settings
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: viewModel.isLoading
                    ? null
                    : () {
                        _showResetConfirmationDialog(context);
                      },
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.error,
                  side: BorderSide(color: colorScheme.error),
                ),
                icon: const Icon(Icons.restore_outlined, size: 20),
                label: const Text('Reset All Settings'),
              ),
            ),

            const SizedBox(height: 12),

            // Delete Account
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _showDeleteAccountDialog(context);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.error,
                  side: BorderSide(color: colorScheme.error),
                ),
                icon: const Icon(Icons.delete_forever_outlined, size: 20),
                label: const Text('Delete Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showResetConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text(
          'Are you sure you want to reset all settings to default? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final viewModel = context.read<SettingsViewModel>();
              Navigator.pop(context);
              await viewModel.resetSettings();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Settings reset successfully'),
                  ),
                );
              }
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This will permanently delete all your data and cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deletion requires admin approval'),
                ),
              );
            },
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }
}
