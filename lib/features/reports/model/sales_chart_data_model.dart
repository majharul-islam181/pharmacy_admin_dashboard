enum ChartPeriodFilter {
  today,
  thisWeek,
  thisMonth,
  custom,
}

extension ChartPeriodFilterExtension on ChartPeriodFilter {
  String get displayName {
    switch (this) {
      case ChartPeriodFilter.today:
        return 'Today';
      case ChartPeriodFilter.thisWeek:
        return 'This Week';
      case ChartPeriodFilter.thisMonth:
        return 'This Month';
      case ChartPeriodFilter.custom:
        return 'Custom Range';
    }
  }
}

enum SalesChartType {
  revenue,
  orders,
}

extension SalesChartTypeExtension on SalesChartType {
  String get displayName {
    switch (this) {
      case SalesChartType.revenue:
        return 'Revenue';
      case SalesChartType.orders:
        return 'Orders';
    }
  }
}

class SalesChartDataPoint {
  final String label;
  final double value;

  SalesChartDataPoint({
    required this.label,
    required this.value,
  });
}
