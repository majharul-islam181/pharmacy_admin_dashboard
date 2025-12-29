import 'package:flutter/material.dart';
import '../../model/sales_chart_data_model.dart';
import '../../../../core/constants/app_dimensions.dart';

class SalesOverviewCard extends StatelessWidget {
  final SalesChartType selectedChartType;
  final ValueChanged<SalesChartType> onChartTypeChanged;
  final List<SalesChartDataPoint> chartData;

  const SalesOverviewCard({
    super.key,
    required this.selectedChartType,
    required this.onChartTypeChanged,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sales Overview',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'High level view of revenue and orders over time.',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingMedium),
                SegmentedButton<SalesChartType>(
                  style: const ButtonStyle(
                    visualDensity: VisualDensity.compact,
                  ),
                  segments: const [
                    ButtonSegment(
                      value: SalesChartType.revenue,
                      label: Text('Revenue'),
                    ),
                    ButtonSegment(
                      value: SalesChartType.orders,
                      label: Text('Orders'),
                    ),
                  ],
                  selected: {selectedChartType},
                  onSelectionChanged: (Set<SalesChartType> selected) {
                    onChartTypeChanged(selected.first);
                  },
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .outlineVariant
                      .withOpacity(0.5),
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chart placeholder – integrate fl_chart or Syncfusion here.',
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Data points: ${chartData.length}',
                    style: textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
