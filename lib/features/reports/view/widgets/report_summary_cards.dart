import 'package:flutter/material.dart';
import '../../model/report_summary_model.dart';
import '../../../../core/constants/app_dimensions.dart';

class ReportSummaryCards extends StatelessWidget {
  final List<ReportSummaryModel> summaries;

  const ReportSummaryCards({
    super.key,
    required this.summaries,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isNarrow = maxWidth < 900;

        return Wrap(
          spacing: AppDimensions.paddingMedium,
          runSpacing: AppDimensions.paddingMedium,
          children: summaries.map((summary) {
            return _buildSummaryCard(
              context,
              summary: summary,
              maxWidth: isNarrow
                  ? maxWidth
                  : (maxWidth - 3 * AppDimensions.paddingMedium) / 4,
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required ReportSummaryModel summary,
    required double maxWidth,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Card.outlined(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                    child: Icon(
                      summary.type.icon,
                      size: 20,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    summary.type.title,
                    style: textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                summary.value,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                summary.subtitle,
                style: textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    summary.trendPositive
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    size: 18,
                    color: summary.trendPositive
                        ? Colors.green[600]
                        : Colors.red[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    summary.trendLabel,
                    style: textTheme.bodySmall?.copyWith(
                      color: summary.trendPositive
                          ? Colors.green[700]
                          : Colors.red[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
