class SalesChartData {
  final List<double> revenueData;
  final List<double> otherData;
  final List<String> months;

  SalesChartData({
    required this.revenueData,
    required this.otherData,
    required this.months,
  });
}

class RevenueChartData {
  final List<double> actualData;
  final List<double> forecastData;
  final List<String> months;

  RevenueChartData({
    required this.actualData,
    required this.forecastData,
    required this.months,
  });
}
