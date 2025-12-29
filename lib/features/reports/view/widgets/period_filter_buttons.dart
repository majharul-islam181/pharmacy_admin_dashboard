import 'package:flutter/material.dart';
import '../../model/sales_chart_data_model.dart';

class PeriodFilterButtons extends StatelessWidget {
  final ChartPeriodFilter selectedPeriod;
  final ValueChanged<ChartPeriodFilter> onPeriodChanged;

  const PeriodFilterButtons({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.end,
      children: [
        _buildFilterButton(
          context,
          period: ChartPeriodFilter.today,
          isSelected: selectedPeriod == ChartPeriodFilter.today,
        ),
        _buildFilterButton(
          context,
          period: ChartPeriodFilter.thisWeek,
          isSelected: selectedPeriod == ChartPeriodFilter.thisWeek,
        ),
        _buildFilterButton(
          context,
          period: ChartPeriodFilter.thisMonth,
          isSelected: selectedPeriod == ChartPeriodFilter.thisMonth,
        ),
        _buildFilterButton(
          context,
          period: ChartPeriodFilter.custom,
          isSelected: selectedPeriod == ChartPeriodFilter.custom,
          icon: Icons.calendar_today_outlined,
        ),
      ],
    );
  }

  Widget _buildFilterButton(
    BuildContext context, {
    required ChartPeriodFilter period,
    required bool isSelected,
    IconData? icon,
  }) {
    if (isSelected) {
      return FilledButton.tonal(
        onPressed: () => onPeriodChanged(period),
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 18),
                  const SizedBox(width: 4),
                  Text(period.displayName),
                ],
              )
            : Text(period.displayName),
      );
    }

    return OutlinedButton(
      onPressed: () => onPeriodChanged(period),
      child: icon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18),
                const SizedBox(width: 4),
                Text(period.displayName),
              ],
            )
          : Text(period.displayName),
    );
  }
}
