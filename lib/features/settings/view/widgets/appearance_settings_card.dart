import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/settings_view_model.dart';
import '../../../../core/constants/app_dimensions.dart';

class AppearanceSettingsCard extends StatelessWidget {
  const AppearanceSettingsCard({super.key});

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
                  Icons.palette_outlined,
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Appearance',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Customize the look and feel of the application',
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

            // Theme Toggle
            _buildSettingRow(
              context,
              title: 'Dark Mode',
              subtitle: 'Switch between light and dark themes',
              trailing: Switch(
                value: viewModel.isDarkMode,
                onChanged: (_) => viewModel.toggleTheme(),
              ),
            ),

            const SizedBox(height: 12),

            // Theme Mode Selector
            _buildSettingRow(
              context,
              title: 'Theme Mode',
              subtitle: 'Select your preferred theme mode',
              trailing: SegmentedButton<ThemeMode>(
                style: const ButtonStyle(
                  visualDensity: VisualDensity.compact,
                ),
                segments: const [
                  ButtonSegment(
                    value: ThemeMode.light,
                    icon: Icon(Icons.light_mode, size: 18),
                  ),
                  ButtonSegment(
                    value: ThemeMode.system,
                    icon: Icon(Icons.settings_suggest, size: 18),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    icon: Icon(Icons.dark_mode, size: 18),
                  ),
                ],
                selected: {viewModel.themeMode},
                onSelectionChanged: (Set<ThemeMode> selected) {
                  viewModel.setThemeMode(selected.first);
                },
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
}
