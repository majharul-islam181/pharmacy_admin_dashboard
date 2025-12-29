import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/settings_view_model.dart';
import '../../../../core/constants/app_dimensions.dart';

class SecuritySettingsCard extends StatelessWidget {
  const SecuritySettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();
    final textTheme = Theme.of(context).textTheme;

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
                  Icons.security_outlined,
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Security & Privacy',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Keep your account secure and private',
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

            // Two-Factor Authentication
            _buildSettingRow(
              context,
              title: 'Two-Factor Authentication',
              subtitle: 'Add an extra layer of security to your account',
              trailing: Switch(
                value: viewModel.twoFactorAuth,
                onChanged: (value) => viewModel.setTwoFactorAuth(value),
              ),
            ),

            const SizedBox(height: 16),

            // Auto Backup
            _buildSettingRow(
              context,
              title: 'Automatic Backup',
              subtitle: 'Automatically backup your data daily',
              trailing: Switch(
                value: viewModel.autoBackup,
                onChanged: (value) => viewModel.setAutoBackup(value),
              ),
            ),

            const SizedBox(height: AppDimensions.paddingMedium),
            const Divider(height: 1),
            const SizedBox(height: AppDimensions.paddingMedium),

            // Change Password Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _showChangePasswordDialog(context);
                },
                icon: const Icon(Icons.lock_outline, size: 20),
                label: const Text('Change Password'),
              ),
            ),

            const SizedBox(height: 12),

            // Session Management Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Show active sessions
                },
                icon: const Icon(Icons.devices_outlined, size: 20),
                label: const Text('Manage Active Sessions'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(
    BuildContext context, {
    required String title,
    String? subtitle,
    required Widget trailing,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 16),
        trailing,
      ],
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final viewModel = context.read<SettingsViewModel>();
              viewModel.changePassword(
                oldPasswordController.text,
                newPasswordController.text,
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password changed successfully')),
              );
            },
            child: const Text('Change Password'),
          ),
        ],
      ),
    );
  }
}
