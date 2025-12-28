class DashboardStatModel {
  final String title;
  final int count;
  final String icon;
  final String trend;

  DashboardStatModel({
    required this.title,
    required this.count,
    required this.icon,
    required this.trend,
  });
}

class ChartDataModel {
  final String label;
  final double value;

  ChartDataModel({
    required this.label,
    required this.value,
  });
}
