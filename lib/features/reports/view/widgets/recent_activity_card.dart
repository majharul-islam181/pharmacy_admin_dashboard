import 'package:flutter/material.dart';
import '../../model/report_activity_model.dart';
import '../../../../core/constants/app_dimensions.dart';

class RecentActivityCard extends StatelessWidget {
  final List<ReportActivityModel> activities;
  final VoidCallback onExportPdf;
  final VoidCallback onExportCsv;

  const RecentActivityCard({
    super.key,
    required this.activities,
    required this.onExportPdf,
    required this.onExportCsv,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card.filled(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Report Activity',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Quick history of report exports and scheduled summaries.',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingMedium),
                FilledButton.icon(
                  onPressed: onExportPdf,
                  icon: const Icon(Icons.file_download_outlined, size: 18),
                  label: const Text('Export PDF'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: onExportCsv,
                  icon: const Icon(Icons.table_chart_outlined, size: 18),
                  label: const Text('Export CSV'),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            const Divider(height: 1),
            const SizedBox(height: AppDimensions.paddingMedium),
            if (activities.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                  child: Text(
                    'No recent activities',
                    style: textTheme.bodySmall,
                  ),
                ),
              )
            else
              ...activities.map((activity) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildActivityRow(context, activity),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityRow(
    BuildContext context,
    ReportActivityModel activity,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
          child: Icon(
            activity.type.icon,
            size: 18,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingMedium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity.title,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                activity.subtitle,
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppDimensions.paddingMedium),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            activity.type.label,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}
