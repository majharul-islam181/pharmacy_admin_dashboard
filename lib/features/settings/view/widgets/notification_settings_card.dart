import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/settings_view_model.dart';
import '../../../../core/constants/app_dimensions.dart';

class NotificationSettingsCard extends StatelessWidget {
  const NotificationSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();
    final textTheme = Theme.of(context).textTheme;
    final settings = viewModel.notificationSettings;

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
                  Icons.notifications_outlined,
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notifications',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Manage how you receive notifications',
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

            // Notification Channels
            Text(
              'Notification Channels',
              style: textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            _buildSwitchTile(
              context,
              title: 'Email Notifications',
              subtitle: 'Receive notifications via email',
              value: settings.emailNotifications,
              onChanged: viewModel.updateEmailNotifications,
            ),
            _buildSwitchTile(
              context,
              title: 'Push Notifications',
              subtitle: 'Receive push notifications in the app',
              value: settings.pushNotifications,
              onChanged: viewModel.updatePushNotifications,
            ),
            _buildSwitchTile(
              context,
              title: 'SMS Notifications',
              subtitle: 'Receive notifications via SMS',
              value: settings.smsNotifications,
              onChanged: viewModel.updateSmsNotifications,
            ),

            const SizedBox(height: AppDimensions.paddingMedium),

            // Notification Types
            Text(
              'Notification Types',
              style: textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            _buildSwitchTile(
              context,
              title: 'Order Updates',
              subtitle: 'Get notified about order status changes',
              value: settings.orderUpdates,
              onChanged: viewModel.updateOrderUpdates,
            ),
            _buildSwitchTile(
              context,
              title: 'Inventory Alerts',
              subtitle: 'Get alerts for low stock and inventory issues',
              value: settings.inventoryAlerts,
              onChanged: viewModel.updateInventoryAlerts,
            ),
            _buildSwitchTile(
              context,
              title: 'System Alerts',
              subtitle: 'Get notified about system updates and maintenance',
              value: settings.systemAlerts,
              onChanged: viewModel.updateSystemAlerts,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
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
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
